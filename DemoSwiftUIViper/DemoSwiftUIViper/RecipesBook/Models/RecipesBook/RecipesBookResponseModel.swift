import Foundation

struct RecipesBookResponseModel: Codable {
    let title: String?
    let version: Float?
    let href: URL?
    let results: [RecipeDataModel]?
}
