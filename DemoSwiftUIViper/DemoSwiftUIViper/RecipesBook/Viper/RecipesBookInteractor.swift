import Combine
import Foundation

protocol RecipesBookInteractorProtocol {
    
}

final class RecipesBookInteractor {
    private let dependencies: RecipesBookInteractorDependenciesProtocol
    
    
    init(dependencies: RecipesBookInteractorDependenciesProtocol) {
        self.dependencies = dependencies
        
    }
}

extension RecipesBookInteractor: RecipesBookInteractorProtocol {

}
