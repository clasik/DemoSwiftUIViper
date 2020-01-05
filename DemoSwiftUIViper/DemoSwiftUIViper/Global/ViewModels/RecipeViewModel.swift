import Foundation
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

extension RecipeViewModel {
    var isFavourite: Bool {
        return true
    }

    var hasLactose: Bool {
        return ingredients.lowercased().contains("milk") || ingredients.lowercased().contains("cheese")
    }
}
