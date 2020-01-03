import SwiftUI

struct RecipeViewModel {
    let title: String
    let href: URL
    let ingredients: String
    let thumbnail: URL
}

extension RecipeViewModel: Identifiable {
    var id: String { href.absoluteString }
}

