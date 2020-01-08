@testable import DemoSwiftUIViper
import XCTest

class RecipesBookViewTests: XCTestCase {
    var sut: RecipesBookView!

    override func setUp() {
        super.setUp()
        sut = RecipesBookView()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBodyExists() {
        XCTAssertNotNil(sut.body)
    }
}
