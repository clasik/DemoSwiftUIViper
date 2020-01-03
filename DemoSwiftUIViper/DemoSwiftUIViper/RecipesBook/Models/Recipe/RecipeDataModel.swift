import Foundation

struct RecipeDataModel: Codable {
    let title: String
    let href: URL
    let ingredients: String
    let thumbnail: URL
}
