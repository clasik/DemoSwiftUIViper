import SwiftUI

protocol RecipesBookViewProtocol: RecipesBookProtocol {

}

struct RecipesBookView: View {
    @ObservedObject private var presenter = RecipesBookWireframe.makePresenter()
    weak var delegate: RecipesBookDelegateProtocol?

    @State private var isLoading: Bool = false
    @State var ingredients: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("filter_by_ingredients".localized, text: $ingredients, onCommit: {
                    self.presenter.didTriggerAction(.updateIngredients(self.ingredients))
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(presenter.recipeViewModels, rowContent: { recipeViewModel in
                    NavigationLink(destination: RecipeDetailView(recipe: recipeViewModel)) {
                        RecipeCellView(recipe: recipeViewModel).onAppear {
                            self.listItemAppears(recipeViewModel)
                        }
                    }
                })
            }.navigationBarTitle("recipes".localized).navigationBarItems(trailing:
                NavigationLink(destination: FavoriteRecipesView()) {
                    Image(systemName: "heart.fill")
                }
            )
        }
        .onAppear {
            self.presenter.didReceiveEvent(.viewAppears)
        }
        .onDisappear {
            self.presenter.didReceiveEvent(.viewDisappears)
        }
    }

    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if presenter.recipeViewModels.closeToLastItem(item) {
            self.presenter.didTriggerAction(.nextPage)
        }
    }
}

extension RecipesBookView: RecipesBookViewProtocol {

}

extension RecipesBookView: RecipesBookProtocol {

}

#if DEBUG
struct RecipesBookView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesBookView()
    }
}
#endif
