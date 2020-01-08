import Combine
import SwiftUI

protocol FavouriteRecipesPresenterProtocol: class {
    func didReceiveEvent(_ event: FavouriteRecipesEvent)
    func didTriggerAction(_ action: FavouriteRecipesAction)
}

final class FavouriteRecipesPresenter: NSObject, ObservableObject {
    private let dependencies: FavouriteRecipesPresenterDependenciesProtocol
    private var interactor: FavouriteRecipesInteractorProtocol
    private var getCurrentRecipesCancellable: [AnyCancellable] = []

    @Published private(set) var recipeViewModels: [RecipeViewModel] = []

    init(dependencies: FavouriteRecipesPresenterDependenciesProtocol,
         interactor: FavouriteRecipesInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
    }
}

extension FavouriteRecipesPresenter: FavouriteRecipesPresenterProtocol {
    func didReceiveEvent(_ event: FavouriteRecipesEvent) {
        switch event {
        case .viewAppears:
            getCurrentRecipes()
        case .viewDisappears:
            getCurrentRecipesCancellable.forEach { anyCancellable in
                anyCancellable.cancel()
            }
        }
    }

    func didTriggerAction(_ action: FavouriteRecipesAction) {
        switch action {
        case let .makeFavourite(recipe):
            makeFavourite(recipe: recipe)
        case .retry:
            getCurrentRecipes()
        }
    }
}

extension FavouriteRecipesPresenter {
    private func getCurrentRecipes() {
        let recipeViewModels: [RecipeViewModel] = interactor.getRecipes().compactMap { recipeDataModel in
            RecipeViewModel(title: recipeDataModel.title,
                            href: recipeDataModel.href,
                            ingredients: recipeDataModel.ingredients,
                            thumbnail: recipeDataModel.thumbnail,
                            favourite: self.interactor.checkIsFavourite(recipe: recipeDataModel),
                            hasLactose: recipeDataModel.ingredients.lowercased().contains("milk") ||
                                recipeDataModel.ingredients.lowercased().contains("cheese"))
        }
        self.recipeViewModels.append(contentsOf: recipeViewModels)
    }

    private func makeFavourite(recipe: RecipeViewModel) {
        interactor.makeFavourite(recipe: RecipeDataModel(title: recipe.title,
                                                         href: recipe.href,
                                                         ingredients: recipe.ingredients,
                                                         thumbnail: recipe.thumbnail))
        recipeViewModels.removeAll(where: { $0.title == recipe.title })
    }
}
