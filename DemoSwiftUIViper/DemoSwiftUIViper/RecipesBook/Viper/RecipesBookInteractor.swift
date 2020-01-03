import Combine
import Foundation

protocol RecipesBookInteractorProtocol {
    var pageSize: Int { get }
    var allRecipesLoaded: Bool { get set }
    func getCurrentRecipes() -> AnyPublisher<[RecipeDataModel], Error>
    func getNextRecipes() -> AnyPublisher<[RecipeDataModel], Error>
}

final class RecipesBookInteractor {
    private let dependencies: RecipesBookInteractorDependenciesProtocol
    private var currentPage: Int
    private var ingredients: String
    
    let pageSize: Int
    var allRecipesLoaded: Bool
    init(dependencies: RecipesBookInteractorDependenciesProtocol) {
        self.dependencies = dependencies
        currentPage = 1
        pageSize = 50
        allRecipesLoaded = false
        ingredients = "onion"
    }
}

extension RecipesBookInteractor: RecipesBookInteractorProtocol {
    
    func getCurrentRecipes() -> AnyPublisher<[RecipeDataModel], Error> {
        return self.dependencies.apiService.getRecipes(page: currentPage, ingredients: ingredients)
            .tryCompactMap { recipesBookResponseModel in
                //recipeResponseModels in
            //return try recipeResponseModels.compactMap { try $0.recipeDataModel() }
                return try recipesBookResponseModel.recipesBookDataModel().results
        }.eraseToAnyPublisher()
    }
    
    func getNextRecipes() -> AnyPublisher<[RecipeDataModel], Error> {
        currentPage += 1
        return self.dependencies.apiService.getRecipes(page: currentPage, ingredients: ingredients)
            .tryCompactMap { recipesBookResponseModel in
                //recipeResponseModels in
            //return try recipeResponseModels.compactMap { try $0.recipeDataModel() }
            return try recipesBookResponseModel.recipesBookDataModel().results
        }.eraseToAnyPublisher()
    }
    
    
}
