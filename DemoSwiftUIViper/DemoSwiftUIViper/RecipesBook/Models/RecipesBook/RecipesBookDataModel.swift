import Foundation

struct RecipesBookDataModel: Codable {
    let title: String
    let version: Float
    let href: String
    let results: [RecipeDataModel]
}
