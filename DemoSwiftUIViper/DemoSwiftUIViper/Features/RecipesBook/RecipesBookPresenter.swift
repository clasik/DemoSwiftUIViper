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
            getCurrentRecipesCancellable.forEach({ anyCancellable in
                anyCancellable.cancel()
            })
            getNextRecipesCancellable.forEach({ anyCancellable in
                anyCancellable.cancel()
            })
        }
    }
    
    func didTriggerAction(_ action: RecipesBookAction) {
        switch action {
        case .retry:
            getCurrentRecipes()
        case .makeFavourite(let recipe):
            makeFavourite(recipe: recipe)
        case .nextPage:
            getNextRecipes()
        case .updateIngredients(let ingredients):
            self.interactor.ingredients = ingredients
            self.interactor.currentPage = 1
            self.interactor.allRecipesLoaded = false
            self.recipeViewModels.removeAll()
            getCurrentRecipes()
        }
    }
}

extension RecipesBookPresenter {
    private func getCurrentRecipes() {
        self.getCurrentRecipesCancellable.append(self.interactor.getCurrentRecipes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if let interactorError = error as? RecipesBookInteractorError, interactorError == .allRecipesLoaded {
                        self.interactor.allRecipesLoaded = true
                    }
                case .finished: break
                    
                }
            }) { recipeDataModels in
                let recipeViewModels: [RecipeViewModel] = recipeDataModels.compactMap { recipeDataModel in                    
                    return RecipeViewModel(title: recipeDataModel.title,
                                           href: recipeDataModel.href,
                                           ingredients: recipeDataModel.ingredients,
                                           thumbnail: recipeDataModel.thumbnail,
                                           favourite: self.interactor.checkIsFavourite(recipe: recipeDataModel),
                                           hasLactose: recipeDataModel.ingredients.lowercased().contains("milk") || recipeDataModel.ingredients.lowercased().contains("cheese"))
                }
                self.recipeViewModels.append(contentsOf: recipeViewModels)
        })
    }
    
    private func getNextRecipes() {
        guard !interactor.allRecipesLoaded else {
            return
        }
        self.getNextRecipesCancellable.append( self.interactor.getNextRecipes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if let interactorError = error as? RecipesBookInteractorError, interactorError == .allRecipesLoaded {
                        self.interactor.allRecipesLoaded = true
                    }
                case .finished:
                    break
                    
                }
            }) { recipeDataModels in
                let recipeViewModels: [RecipeViewModel] = recipeDataModels.compactMap { recipeDataModel in
                    return RecipeViewModel(title: recipeDataModel.title,
                                           href: recipeDataModel.href,
                                           ingredients: recipeDataModel.ingredients,
                                           thumbnail: recipeDataModel.thumbnail,
                                           favourite: self.interactor.checkIsFavourite(recipe: recipeDataModel),
                                           hasLactose: recipeDataModel.ingredients.lowercased().contains("milk") || recipeDataModel.ingredients.lowercased().contains("cheese"))
                }
                self.recipeViewModels.append(contentsOf: recipeViewModels)
        })
    }
    
    private func makeFavourite(recipe: RecipeViewModel){
        self.interactor.makeFavourite(recipe: RecipeDataModel(title: recipe.title,
                                                             href: recipe.href,
                                                             ingredients: recipe.ingredients,
                                                             thumbnail: recipe.thumbnail))
        if let index = self.recipeViewModels.firstIndex(where: { $0.title == recipe.title}) {
            let newRecipe = RecipeViewModel(title: recipe.title,
                                            href: recipe.href,
                                            ingredients: recipe.ingredients,
                                            thumbnail: recipe.thumbnail,
                                            favourite: !recipe.favourite,
                                            hasLactose: recipe.hasLactose)
            self.recipeViewModels[index] = newRecipe
        }
    }
}
