import Combine
@testable import DemoSwiftUIViper
import XCTest

class RecipesBookPresenterTests: XCTestCase {
    var sut: RecipesBookPresenter!
    var interactor: RecipesBookInteractor!

    override func setUp() {
        super.setUp()
        let interactorDependencies = MockRecipesBookInteractorDependencies()
        interactor = RecipesBookInteractor(dependencies: interactorDependencies)

        let presenterDependencies = RecipesBookPresenterDependencies()
        sut = RecipesBookPresenter(dependencies: presenterDependencies, interactor: interactor)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEventsPresenter() {
        sut.didReceiveEvent(.viewAppears)
        sut.didReceiveEvent(.viewDisappears)

        let exp = expectation(description: "viewAppears")
        let cancellable = sut.$recipeViewModels.sink { recipeViewModels in
            XCTAssertNotNil(recipeViewModels)
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        cancellable.cancel()
    }

    func testActionsPresenter() {
        let item = RecipeViewModel(title: "title",
                                   href: "http://allrecipes.com/Recipe/Eggnog-Thumbprints/Detail.aspx",
                                   ingredients: "ingredients",
                                   thumbnail: "http://img.recipepuppy.com/3.jpg",
                                   favourite: true, hasLactose: true)
        sut.didTriggerAction(.makeFavourite(item))

        sut.didTriggerAction(.nextPage)

        sut.didTriggerAction(.retry)

        sut.didTriggerAction(.updateIngredients("ingredients"))

        let exp = expectation(description: "viewAppears")
        let cancellable = sut.$recipeViewModels.sink { recipeViewModels in
            XCTAssertNotNil(recipeViewModels)
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        cancellable.cancel()
    }
}
