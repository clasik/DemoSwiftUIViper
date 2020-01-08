import XCTest
@testable import DemoSwiftUIViper

class RecipesBookDataModelTests: XCTestCase {

    var sut: RecipesBookResponseModel!
    var rdm: RecipeDataModel!

    override func setUp() {
        super.setUp()
        rdm = RecipeDataModel(title: "title",
                                  href: "http://allrecipes.com/Recipe/Ginger-Champagne/Detail.aspx",
                                  ingredients: "ingredients",
                                  thumbnail: "thumbnail")
        sut = RecipesBookResponseModel(title: "title",
                                       version: 1.0,
                                       href: "http://www.recipepuppy.com",
                                       results: [rdm])
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExists() {
        XCTAssertNotNil(sut)
    }

    func testToDataModel() {
        let titleNil = RecipesBookResponseModel(title: nil,
                                                version: 1.0,
                                                href: "http://www.recipepuppy.com",
                                                results: [rdm])
        XCTAssertThrowsError(try titleNil.recipesBookDataModel()) { error in
            XCTAssertEqual(error as? RecipesBookDataModelConvertibleError, .missingTitle)
        }

        let versionNil = RecipesBookResponseModel(title: "title",
                                                  version: nil,
                                                  href: "http://www.recipepuppy.com",
                                                  results: [rdm])
        XCTAssertThrowsError(try versionNil.recipesBookDataModel()) { error in
            XCTAssertEqual(error as? RecipesBookDataModelConvertibleError, .missingVersion)
        }

        let hrefNil = RecipesBookResponseModel(title: "title",
                                               version: 1.0,
                                               href: nil,
                                               results: [rdm])
        XCTAssertThrowsError(try hrefNil.recipesBookDataModel()) { error in
            XCTAssertEqual(error as? RecipesBookDataModelConvertibleError, .missingHref)
        }

        let resultsNil = RecipesBookResponseModel(title: "title",
                                                  version: 1.0,
                                                  href: "http://www.recipepuppy.com",
                                                  results: nil)
        XCTAssertThrowsError(try resultsNil.recipesBookDataModel()) { error in
            XCTAssertEqual(error as? RecipesBookDataModelConvertibleError, .missingResults)
        }

        guard let dataModel = try? sut.recipesBookDataModel() else {
            fatalError("recipesBookDataModel Error")
        }
        XCTAssertEqual(dataModel.title, "title")
        XCTAssertEqual(dataModel.version, 1.0)
        XCTAssertEqual(dataModel.href, "http://www.recipepuppy.com")
        XCTAssertEqual(dataModel.results.count, 1)

    }

}
