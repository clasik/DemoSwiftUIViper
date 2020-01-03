import SwiftUI

protocol RecipesBookViewProtocol: RecipesBookProtocol {
    
}

struct RecipesBookView: View {
    @ObservedObject private var presenter = RecipesBookWireframe.makePresenter()
    weak var delegate: RecipesBookDelegateProtocol?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


extension RecipesBookView: RecipesBookViewProtocol {
    
}

extension RecipesBookView: RecipesBookProtocol {
    
}

struct RecipesBookView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesBookView()
    }
}
