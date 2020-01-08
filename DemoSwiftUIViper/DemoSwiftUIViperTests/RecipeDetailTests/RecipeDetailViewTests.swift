import XCTest
@testable import DemoSwiftUIViper

class RecipeDetailViewTests: XCTestCase {

    var sut: RecipeDetailView!

    override func setUp() {
        super.setUp()
        let href = "http://allrecipes.com/Recipe/Ginger-Champagne/Detail.aspx"
        sut = RecipeDetailView(recipe: RecipeViewModel(title: "Title",
                                                       href: href,
                                                       ingredients: "Ingredients",
                                                       thumbnail: href,
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
