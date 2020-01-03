import Foundation

struct RecipeResponseModel: Codable {
    let title: String?
    let href: URL?
    let ingredients: String?
    let thumbnail: URL?
}
