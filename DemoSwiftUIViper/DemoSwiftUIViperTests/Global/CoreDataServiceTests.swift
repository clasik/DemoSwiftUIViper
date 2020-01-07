import XCTest
@testable import DemoSwiftUIViper

class CoreDataServiceTests: XCTestCase {
    
    var sut: CoreDataService!
    var rdm: RecipeDataModel!
    
    override func setUp() {
        super.setUp()
        sut = CoreDataService()
        rdm = RecipeDataModel(title: "title", href: "href", ingredients: "ingredients", thumbnail: "thumbnail")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDBRecipes() {
        sut.deleteRecipe(recipe: rdm)
        sut.makeFavourite(recipe: rdm)
        XCTAssertTrue((sut.getRecipes()?.reversed().count)! > 0)
        XCTAssertTrue(sut.checkIsFavourite(recipe: rdm))
        XCTAssertTrue(sut.deleteRecipe(recipe: rdm))
        XCTAssertFalse(sut.checkIsFavourite(recipe: rdm))
    }
    
}
