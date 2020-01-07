import SwiftUI
import CoreData

protocol FavouriteRecipesViewProtocol: FavouriteRecipesProtocol {

}

struct FavouriteRecipesView: View {
    @ObservedObject private var presenter = FavouriteRecipesWireframe.makePresenter()
    weak var delegate: FavouriteRecipesDelegateProtocol?

    var body: some View {
        List(presenter.recipeViewModels, rowContent: { recipeViewModel in
            NavigationLink(destination: RecipeDetailView(recipe: recipeViewModel)) {
                RecipeCellView(recipe: recipeViewModel, onFavouriteTapGasture: {
                    self.makeFavourite(recipeViewModel)
                })
            }
        }).navigationBarTitle("favourite_list".localized)
            .onAppear {
                DispatchQueue.main.async {
                    self.presenter.didReceiveEvent(.viewAppears)
                }
        }
        .onDisappear {
            self.presenter.didReceiveEvent(.viewDisappears)
        }
    }

    private func makeFavourite<Item: Identifiable>(_ item: Item) {
        if let item = item as? RecipeViewModel {
           self.presenter.didTriggerAction(.makeFavourite(item))
        }
    }
}

extension FavouriteRecipesView: FavouriteRecipesViewProtocol {

}

extension FavouriteRecipesView: FavouriteRecipesProtocol {

}

#if DEBUG
struct FavouriteRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteRecipesView()
    }
}
#endif
