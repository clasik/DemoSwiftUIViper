import XCTest
@testable import DemoSwiftUIViper

class APIServiceTests: XCTestCase {
    
    var sut: APIService!
    
    override func setUp() {
        super.setUp()
        
        let t = type(of: self)
        let bundle = Bundle(for: t.self)
        let path = bundle.path(forResource: "MockRecipesBook", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        sut = APIService(url: url)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetRecipes() {
        let recipes = sut.getRecipes(page: 1, ingredients: "ingredients")
        XCTAssertNotNil(recipes)
    }
    
}




