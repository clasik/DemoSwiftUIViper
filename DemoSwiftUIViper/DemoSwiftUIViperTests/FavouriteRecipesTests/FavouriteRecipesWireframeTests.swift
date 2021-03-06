@testable import DemoSwiftUIViper
import XCTest

class FavouriteRecipesWireframeTests: XCTestCase {
    var sut: FavouriteRecipesWireframe!

    override func setUp() {
        super.setUp()
        sut = FavouriteRecipesWireframe()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testMakePresenter() {
        let presenter: FavouriteRecipesPresenter = FavouriteRecipesWireframe.makePresenter()
        XCTAssertNotNil(presenter)
    }
}
