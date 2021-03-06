import Combine
import SwiftUI

protocol RecipesBookPresenterProtocol: class {
    func didReceiveEvent(_ event: RecipesBookEvent)
    func didTriggerAction(_ action: RecipesBookAction)
}

final class RecipesBookPresenter: NSObject, ObservableObject {
    private let dependencies: RecipesBookPresenterDependenciesProtocol
    private var interactor: RecipesBookInteractorProtocol
    private var getCurrentRecipesCancellable: [AnyCancellable] = []
    private var getNextRecipesCancellable: [AnyCancellable] = []

    @Published private(set) var recipeViewModels: [RecipeViewModel] = []

    init(dependencies: RecipesBookPresenterDependenciesProtocol,
         interactor: RecipesBookInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
    }
}

extension RecipesBookPresenter: RecipesBookPresenterProtocol {
    func didReceiveEvent(_ event: RecipesBookEvent) {
        switch event {
        case .viewAppears:
            getCurrentRecipes()
        case .viewDisappears:
            getCurrentRecipesCancellable.forEach { anyCancellable in
                anyCancellable.cancel()
            }
            getNextRecipesCancellable.forEach { anyCancellable in
                anyCancellable.cancel()
            }
        }
    }

    func didTriggerAction(_ action: RecipesBookAction) {
        switch action {
        case .retry:
            getCurrentRecipes()
        case let .makeFavourite(recipe):
            makeFavourite(recipe: recipe)
        case .nextPage:
            getNextRecipes()
        case let .updateIngredients(ingredients):
            interactor.ingredients = ingredients
            interactor.currentPage = 1
            interactor.allRecipesLoaded = false
            recipeViewModels.removeAll()
            getCurrentRecipes()
        }
    }
}

// swiftlint:disable multiple_closures_with_trailing_closure
extension RecipesBookPresenter {
    private func getRecipeViewModels(from recipeDataModels: [RecipeDataModel]) -> [RecipeViewModel] {
        return recipeDataModels.compactMap { recipeDataModel in
            RecipeViewModel(title: recipeDataModel.title,
                            href: recipeDataModel.href,
                            ingredients: recipeDataModel.ingredients,
                            thumbnail: recipeDataModel.thumbnail,
                            favourite: self.interactor.checkIsFavourite(recipe: recipeDataModel),
                            hasLactose: recipeDataModel.ingredients.lowercased().contains("milk") ||
                                recipeDataModel.ingredients.lowercased().contains("cheese"))
        }
    }

    private func getCurrentRecipes() {
        getCurrentRecipesCancellable.append(interactor.getCurrentRecipes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    if let interactorError = error as? RecipesBookInteractorError,
                        interactorError == .allRecipesLoaded {
                        self.interactor.allRecipesLoaded = true
                    }
                case .finished: break
                }
            }) { recipeDataModels in
                self.recipeViewModels.append(contentsOf: self.getRecipeViewModels(from: recipeDataModels))
        })
    }

    private func getNextRecipes() {
        guard !interactor.allRecipesLoaded else {
            return
        }
        getNextRecipesCancellable.append(interactor.getNextRecipes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    if let interactorError = error as? RecipesBookInteractorError,
                        interactorError == .allRecipesLoaded {
                        self.interactor.allRecipesLoaded = true
                    }
                case .finished:
                    break
                }
            }) { recipeDataModels in
                self.recipeViewModels.append(contentsOf: self.getRecipeViewModels(from: recipeDataModels))
        })
    }

    private func makeFavourite(recipe: RecipeViewModel) {
        interactor.makeFavourite(recipe: RecipeDataModel(title: recipe.title,
                                                         href: recipe.href,
                                                         ingredients: recipe.ingredients,
                                                         thumbnail: recipe.thumbnail))
        if let index = recipeViewModels.firstIndex(where: { $0.title == recipe.title }) {
            let newRecipe = RecipeViewModel(title: recipe.title,
                                            href: recipe.href,
                                            ingredients: recipe.ingredients,
                                            thumbnail: recipe.thumbnail,
                                            favourite: !recipe.favourite,
                                            hasLactose: recipe.hasLactose)
            recipeViewModels[index] = newRecipe
        }
    }
}
