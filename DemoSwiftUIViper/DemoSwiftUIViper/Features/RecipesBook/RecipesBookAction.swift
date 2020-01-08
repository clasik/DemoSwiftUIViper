import Foundation

enum RecipesBookAction {
    case makeFavourite(RecipeViewModel)
    case nextPage
    case retry
    case updateIngredients(String)
}
