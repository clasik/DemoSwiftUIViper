import Combine
import SwiftUI

protocol RecipesBookPresenterProtocol: class {
    func didReceiveEvent(_ event: RecipesBookEvent)
    func didTriggerAction(_ action: RecipesBookAction)
}

final class RecipesBookPresenter: NSObject, ObservableObject {
    private let dependencies: RecipesBookPresenterDependenciesProtocol
    private var interactor: RecipesBookInteractorProtocol
    private var getCurrentRecipesCancellable: AnyCancellable?
    private var getNextRecipesCancellable: AnyCancellable?
    
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
            getCurrentRecipesCancellable?.cancel()
            getNextRecipesCancellable?.cancel()
        }
    }
    
    func didTriggerAction(_ action: RecipesBookAction) {
        switch action {
        case .retry:
            getCurrentRecipes()
        }
    }
}

extension RecipesBookPresenter {
    private func getCurrentRecipes() {
        getCurrentRecipesCancellable = interactor.getCurrentRecipes()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error): break
                
            case .finished: break
                   
                
            }
        }) { recipeDataModels in
            let recipeViewModels: [RecipeViewModel] = recipeDataModels.compactMap { recipeDataModel in
                return RecipeViewModel(title: recipeDataModel.title,
                                       href: recipeDataModel.href,
                                       ingredients: recipeDataModel.ingredients,
                                       thumbnail: recipeDataModel.thumbnail)
            }
            self.recipeViewModels.append(contentsOf: recipeViewModels)
        }
    }
    
    private func getNextRecipes() {
        guard !interactor.allRecipesLoaded else {
            return
        }
                
        getNextRecipesCancellable = interactor.getNextRecipes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        if let interactorError = error as? RecipesBookInteractorError, interactorError == .allRecipesLoaded {
                            
                        } else {
                            
                        }
                    case .finished:
                        break
                    
                }
            }) { recipeDataModels in
                self.interactor.allRecipesLoaded = recipeDataModels.count < self.interactor.pageSize
                let recipeViewModels: [RecipeViewModel] = recipeDataModels.compactMap { recipeDataModel in
                    return RecipeViewModel(title: recipeDataModel.title,
                                           href: recipeDataModel.href,
                                           ingredients: recipeDataModel.ingredients,
                                           thumbnail: recipeDataModel.thumbnail)
                }
                self.recipeViewModels.append(contentsOf: recipeViewModels)
            }
    }
}
