import Foundation
import SwiftUI

struct RecipeViewModel {
    let title: String
    let href: String
    let ingredients: String
    let thumbnail: String
    var favourite: Bool
    let hasLactose: Bool
}

extension RecipeViewModel: Identifiable {
    var id: String { href }
}
