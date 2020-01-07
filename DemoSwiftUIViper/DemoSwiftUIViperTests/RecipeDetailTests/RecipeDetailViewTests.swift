import XCTest
@testable import DemoSwiftUIViper

class RecipeDetailViewTests: XCTestCase {
   
    var sut: RecipeDetailView!
    
    override func setUp() {
        super.setUp()
        sut = RecipeDetailView(recipe: RecipeViewModel(title: "",
                                                       href: "http://allrecipes.com/Recipe/Ginger-Champagne/Detail.aspx",
                                                       ingredients: "",
                                                       thumbnail: "",
                                                       favourite: false,
                                                       hasLactose: false))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBodyExists() {
        XCTAssertNotNil(sut.body)
    }

}
