import SwiftUI

struct RecipeViewModel {
    let title: String
    let href: String
    let ingredients: String
    let thumbnail: String
}

extension RecipeViewModel: Identifiable {
    var id: String { href }
}

