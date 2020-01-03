import SwiftUI

protocol RecipesBookViewProtocol: RecipesBookProtocol {
    
}

struct RecipesBookView: View {
    @ObservedObject private var presenter = RecipesBookWireframe.makePresenter()
    weak var delegate: RecipesBookDelegateProtocol?
    
    var body: some View {
        NavigationView {
            EmptyView()
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
