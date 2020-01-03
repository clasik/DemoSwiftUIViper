import Foundation

enum RecipeDataModelConvertibleError: Error {
    case missingTitle
    case missingHref
    case missingIngredients
    case missingThumbnail
}
