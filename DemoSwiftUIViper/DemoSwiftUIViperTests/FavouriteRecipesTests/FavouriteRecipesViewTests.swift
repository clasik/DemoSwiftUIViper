@testable import DemoSwiftUIViper
import XCTest

class FavouriteRecipesViewTests: XCTestCase {
    var sut: FavouriteRecipesView!

    override func setUp() {
        super.setUp()
        sut = FavouriteRecipesView()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBodyExists() {
        XCTAssertNotNil(sut.body)
    }
}
