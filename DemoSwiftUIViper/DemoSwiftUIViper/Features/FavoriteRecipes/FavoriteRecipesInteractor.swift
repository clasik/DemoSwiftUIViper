import Combine
import Foundation

protocol FavouriteRecipesInteractorProtocol {
    func checkIsFavourite(recipe: RecipeDataModel) -> Bool
    func getRecipes() -> [RecipeDataModel]
    func makeFavourite(recipe: RecipeDataModel)
}

final class FavouriteRecipesInteractor {
    private let dependencies: FavouriteRecipesInteractorDependenciesProtocol

    init(dependencies: FavouriteRecipesInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

extension FavouriteRecipesInteractor: FavouriteRecipesInteractorProtocol {

    func checkIsFavourite(recipe: RecipeDataModel) -> Bool {
        return self.dependencies.coreDataService.checkIsFavourite(recipe: recipe)
    }

    func getRecipes() -> [RecipeDataModel] {
        var recipeDataModels = [RecipeDataModel]()
        let fetechedObjects = self.dependencies.coreDataService.getRecipes()
        fetechedObjects?.forEach({ fetechedObject in
            if let fetechedObject = fetechedObject as? Recipe {
                let recipeDataModel = RecipeDataModel(title: fetechedObject.title ?? "",
                                                      href: fetechedObject.href ?? "",
                                                      ingredients: fetechedObject.ingredients ?? "",
                                                      thumbnail: fetechedObject.thumbnail ?? "")
                recipeDataModels.append(recipeDataModel)
            }
        })
        return recipeDataModels
    }

    func makeFavourite(recipe: RecipeDataModel) {
        _ = self.dependencies.coreDataService.deleteRecipe(recipe: recipe)
    }
}
