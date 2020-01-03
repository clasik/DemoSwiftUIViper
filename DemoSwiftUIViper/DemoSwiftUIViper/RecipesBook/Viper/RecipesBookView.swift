import SwiftUI

protocol RecipesBookViewProtocol: RecipesBookProtocol {
    
}

struct RecipesBookView: View {
    @ObservedObject private var presenter = RecipesBookWireframe.makePresenter()
    weak var delegate: RecipesBookDelegateProtocol?
    
    @State var name: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Filter by ingredients", text: $name, onCommit: {
                    
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                List(presenter.recipeViewModels, rowContent: { recipeViewModel in
                    // NavigationLink(destination: RecipeDetailView(url: recipeViewModel.href)) {
                    Text(recipeViewModel.title)
                    // }
                })
            }.navigationBarTitle("Recipes")
        }
        .onAppear {
            self.presenter.didReceiveEvent(.viewAppears)
        }
        .onDisappear {
            self.presenter.didReceiveEvent(.viewDisappears)
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
