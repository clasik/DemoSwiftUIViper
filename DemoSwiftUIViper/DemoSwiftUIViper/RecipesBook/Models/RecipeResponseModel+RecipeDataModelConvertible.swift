import Foundation

extension RecipeResponseModel: RecipeDataModelConvertible {
    func recipeDataModel() throws -> RecipeDataModel {
        return RecipeDataModel()
    }
}
