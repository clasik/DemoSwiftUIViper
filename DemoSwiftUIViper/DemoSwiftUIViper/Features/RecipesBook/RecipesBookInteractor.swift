import Combine
import Foundation

protocol RecipesBookInteractorProtocol {
    var allRecipesLoaded: Bool { get set }
    var currentPage: Int { get set }
    var ingredients: String { get set }
    var pageSize: Int { get }

    func checkIsFavourite(recipe: RecipeDataModel) -> Bool
    func getCurrentRecipes() -> AnyPublisher<[RecipeDataModel], Error>
    func getNextRecipes() -> AnyPublisher<[RecipeDataModel], Error>
    func makeFavourite(recipe: RecipeDataModel)
}

final class RecipesBookInteractor {
    private let dependencies: RecipesBookInteractorDependenciesProtocol

    var allRecipesLoaded: Bool
    var currentPage: Int
    var ingredients: String
    let pageSize: Int

    init(dependencies: RecipesBookInteractorDependenciesProtocol) {
        self.dependencies = dependencies
        currentPage = 1
        pageSize = 10
        allRecipesLoaded = false
        ingredients = ""
    }
}

extension RecipesBookInteractor: RecipesBookInteractorProtocol {
    func checkIsFavourite(recipe: RecipeDataModel) -> Bool {
        return dependencies.coreDataService.checkIsFavourite(recipe: recipe)
    }

    func getCurrentRecipes() -> AnyPublisher<[RecipeDataModel], Error> {
        return dependencies.apiService.getRecipes(page: currentPage, ingredients: ingredients)
            .tryCompactMap { recipesBookResponseModel in
                try recipesBookResponseModel.recipesBookDataModel().results
            }.eraseToAnyPublisher()
    }

    func getNextRecipes() -> AnyPublisher<[RecipeDataModel], Error> {
        currentPage += 1
        return dependencies.apiService.getRecipes(page: currentPage, ingredients: ingredients)
            .tryCompactMap { recipesBookResponseModel in
                try recipesBookResponseModel.recipesBookDataModel().results
            }.eraseToAnyPublisher()
    }

    func makeFavourite(recipe: RecipeDataModel) {
        dependencies.coreDataService.makeFavourite(recipe: recipe)
    }
}
