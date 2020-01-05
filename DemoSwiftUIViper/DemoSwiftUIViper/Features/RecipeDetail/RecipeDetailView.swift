import SwiftUI

struct RecipeDetailView: View {
    let recipe: RecipeViewModel

    var body: some View {
        WebView(request: URLRequest(url: URL(string: recipe.href)!))
            .navigationBarTitle(Text(recipe.title), displayMode: .inline)
    }
}

#if DEBUG
struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel(title: "", href: "", ingredients: "", thumbnail: "")
        return RecipeDetailView(recipe: recipe)
    }
}
#endif
