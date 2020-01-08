import Combine
@testable import DemoSwiftUIViper
import XCTest

class RecipesBookInteractorTests: XCTestCase {
    var sut: RecipesBookInteractor!
    var rdm: RecipeDataModel!

    override func setUp() {
        super.setUp()
        let interactorDependencies = MockRecipesBookInteractorDependencies()
        sut = RecipesBookInteractor(dependencies: interactorDependencies)
        rdm = RecipeDataModel(title: "title", href: "href", ingredients: "ingredients", thumbnail: "thumbnail")
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetCurrentRecipes() {
        let publisher = sut.getCurrentRecipes()
        let validTest = evalValidResponseTest(publisher: publisher)
        wait(for: validTest.expectations, timeout: 3)
        validTest.cancellable?.cancel()
    }

    func testNextCurrentRecipes() {
        let publisher = sut.getNextRecipes()
        let validTest = evalValidResponseTest(publisher: publisher)
        wait(for: validTest.expectations, timeout: 3)
        validTest.cancellable?.cancel()
    }

    func testMakeFavourite() {
        sut.makeFavourite(recipe: rdm)
        XCTAssertTrue(sut.checkIsFavourite(recipe: rdm))
    }
}
