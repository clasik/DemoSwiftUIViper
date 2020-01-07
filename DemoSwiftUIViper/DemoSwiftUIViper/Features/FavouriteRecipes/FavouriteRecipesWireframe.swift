import Foundation

protocol FavouriteRecipesWireframeProtocol {
    static func makePresenter() -> FavouriteRecipesPresenter
}

struct FavouriteRecipesWireframe: FavouriteRecipesWireframeProtocol {
    static func makePresenter() -> FavouriteRecipesPresenter {
        let interactorDependencies = FavouriteRecipesInteractorDependencies()
        let interactor = FavouriteRecipesInteractor(dependencies: interactorDependencies)

        let presenterDependencies = FavouriteRecipesPresenterDependencies()
        let presenter = FavouriteRecipesPresenter(dependencies: presenterDependencies,
                                             interactor: interactor)
        return presenter
    }
}
