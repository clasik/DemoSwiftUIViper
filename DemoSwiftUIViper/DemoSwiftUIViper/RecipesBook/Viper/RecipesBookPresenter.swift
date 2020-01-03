import Combine
import SwiftUI

protocol RecipesBookPresenterProtocol: class {
    
}

final class RecipesBookPresenter: NSObject, ObservableObject {
    private let dependencies: RecipesBookPresenterDependenciesProtocol
    private var interactor: RecipesBookInteractorProtocol


    init(dependencies: RecipesBookPresenterDependenciesProtocol,
         interactor: RecipesBookInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
    }
}

extension RecipesBookPresenter: RecipesBookPresenterProtocol {
    func didReceiveEvent(_ event: RecipesBookEvent) {
          switch event {
          case .viewAppears: break
            
          case .viewDisappears: break
            
          }
      }

      func didTriggerAction(_ action: RecipesBookAction) {
          switch action {
          case .retry: break
          }
      }
}
