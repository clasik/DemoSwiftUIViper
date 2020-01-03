import Foundation

extension RecipeResponseModel: RecipeDataModelConvertible {
    func recipeDataModel() throws -> RecipeDataModel {
        guard let title = title else {
            throw RecipeDataModelConvertibleError.missingTitle
        }
        guard let href = href else {
            throw RecipeDataModelConvertibleError.missingHref
        }
        guard let ingredients = ingredients else {
            throw RecipeDataModelConvertibleError.missingIngredients
        }
        guard let thumbnail = thumbnail else {
            throw RecipeDataModelConvertibleError.missingThumbnail
        }
        return RecipeDataModel(title: title, href: href, ingredients: ingredients, thumbnail: thumbnail)
    }
}
