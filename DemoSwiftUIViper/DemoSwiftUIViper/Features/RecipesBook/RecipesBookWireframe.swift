import Foundation

protocol RecipesBookWireframeProtocol {
    static func makePresenter() -> RecipesBookPresenter
}

struct RecipesBookWireframe: RecipesBookWireframeProtocol {
    static func makePresenter() -> RecipesBookPresenter {
        let interactorDependencies = RecipesBookInteractorDependencies()
        let interactor = RecipesBookInteractor(dependencies: interactorDependencies)

        let presenterDependencies = RecipesBookPresenterDependencies()
        let presenter = RecipesBookPresenter(dependencies: presenterDependencies,
                                             interactor: interactor)
        return presenter
    }
}
