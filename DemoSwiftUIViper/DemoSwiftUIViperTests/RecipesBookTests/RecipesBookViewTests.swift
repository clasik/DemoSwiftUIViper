import XCTest
@testable import DemoSwiftUIViper

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
