import XCTest
import Combine
@testable import DemoSwiftUIViper

class FavouriteRecipesInteractorTests: XCTestCase {
    
    var sut: FavouriteRecipesInteractor!
    var rdm: RecipeDataModel!
    
    override func setUp() {
        super.setUp()
        let interactorDependencies = FavouriteRecipesInteractorDependencies()
        sut = FavouriteRecipesInteractor(dependencies: interactorDependencies)
        rdm = RecipeDataModel(title: "FavouriteRecipesInteractorTests", href: "href", ingredients: "ingredients", thumbnail: "thumbnail")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInteractor() {
        sut.makeFavourite(recipe: rdm)
        XCTAssertTrue(sut.checkIsFavourite(recipe: rdm))
        XCTAssertTrue(sut.getRecipes().count > 0)
    }
    
}


