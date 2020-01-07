import XCTest
@testable import DemoSwiftUIViper

class RecipesBookWireframeTests: XCTestCase {
    
    var sut: RecipesBookWireframe!
    
    override func setUp() {
        super.setUp()
        sut = RecipesBookWireframe()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMakePresenter() {
        let presenter: RecipesBookPresenter = RecipesBookWireframe.makePresenter()
        XCTAssertNotNil(presenter)
    }
}

