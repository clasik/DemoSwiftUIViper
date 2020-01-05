import Combine
import Foundation

protocol RecipesBookInteractorProtocol {
    var allRecipesLoaded: Bool { get set }
    var currentPage: Int { get set }
    var ingredients: String { get set }
    var pageSize: Int { get }

    func getCurrentRecipes() -> AnyPublisher<[RecipeDataModel], Error>
    func getNextRecipes() -> AnyPublisher<[RecipeDataModel], Error>
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
        pageSize = 50
        allRecipesLoaded = false
        ingredients = ""
    }
}

extension RecipesBookInteractor: RecipesBookInteractorProtocol {

    func getCurrentRecipes() -> AnyPublisher<[RecipeDataModel], Error> {
        return self.dependencies.apiService.getRecipes(page: currentPage, ingredients: ingredients)
            .tryCompactMap { recipesBookResponseModel in
                return try recipesBookResponseModel.recipesBookDataModel().results
        }.eraseToAnyPublisher()
    }

    func getNextRecipes() -> AnyPublisher<[RecipeDataModel], Error> {
        currentPage += 1
        return self.dependencies.apiService.getRecipes(page: currentPage, ingredients: ingredients)
            .tryCompactMap { recipesBookResponseModel in
            return try recipesBookResponseModel.recipesBookDataModel().results
        }.eraseToAnyPublisher()
    }
}
