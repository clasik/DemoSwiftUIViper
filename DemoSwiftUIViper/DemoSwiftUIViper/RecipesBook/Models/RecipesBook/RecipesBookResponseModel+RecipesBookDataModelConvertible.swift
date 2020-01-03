import Foundation

protocol RecipesBookDataModelConvertible {
    func recipesBookDataModel() throws -> RecipesBookDataModel
}

extension RecipesBookResponseModel: RecipesBookDataModelConvertible {
    func recipesBookDataModel() throws -> RecipesBookDataModel {
        guard let title = title else {
            throw RecipeDataModelConvertibleError.missingTitle
        }
        guard let href = href else {
            throw RecipeDataModelConvertibleError.missingHref
        }
        guard let version = version else {
            throw RecipeDataModelConvertibleError.missingIngredients
        }
        guard let results = results else {
            throw RecipeDataModelConvertibleError.missingThumbnail
        }
        
        var newResult: [RecipeDataModel] = []
        
        newResult = try results.compactMap { try $0.recipeDataModel() }
        
        return RecipesBookDataModel(title: title, version: version, href: href, results: results)
    }
}
