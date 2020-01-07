import XCTest
@testable import DemoSwiftUIViper

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
