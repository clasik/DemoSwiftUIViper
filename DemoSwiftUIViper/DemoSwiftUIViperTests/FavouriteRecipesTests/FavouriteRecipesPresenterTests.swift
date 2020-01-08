import Combine
@testable import DemoSwiftUIViper
import XCTest

class FavouriteRecipesPresenterTests: XCTestCase {
    var sut: FavouriteRecipesPresenter!
    var interactor: FavouriteRecipesInteractor!

    override func setUp() {
        super.setUp()
        let interactorDependencies = FavouriteRecipesInteractorDependencies()
        interactor = FavouriteRecipesInteractor(dependencies: interactorDependencies)

        let presenterDependencies = FavouriteRecipesPresenterDependencies()
        sut = FavouriteRecipesPresenter(dependencies: presenterDependencies, interactor: interactor)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEventsPresenter() {
        sut.didReceiveEvent(.viewAppears)
        sut.didReceiveEvent(.viewDisappears)
    }

    func testActionsPresenter() {
        let item = RecipeViewModel(title: "title",
                                   href: "http://allrecipes.com/Recipe/Eggnog-Thumbprints/Detail.aspx",
                                   ingredients: "ingredients",
                                   thumbnail: "http://img.recipepuppy.com/3.jpg",
                                   favourite: true, hasLactose: true)
        sut.didTriggerAction(.makeFavourite(item))
        sut.didTriggerAction(.retry)
    }
}
