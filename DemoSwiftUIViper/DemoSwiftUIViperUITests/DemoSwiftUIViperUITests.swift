import XCTest

class DemoSwiftUIViperUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    func testSearch() {
        let textField = app.textFields["Filter by ingredients"]
        XCTAssertTrue(textField.waitForExistence(timeout: 5))
        textField.tap()
        textField.typeText("Cheese")
        XCTAssertTrue(app.keyboards.buttons["Return"].waitForExistence(timeout: 5))
        app.keyboards.buttons["intro"].tap()

        let lactoseCell = app.tables
            .buttons["Has lactose\nEasy Easter Carrots (Peter Rabbit's Carrots)\ncheese"]
        XCTAssertTrue(lactoseCell.waitForExistence(timeout: 5))
    }

    func testLactose() {
        let withOutLactoseCell = app.tables.buttons["Ginger Champagne\nchampagne, ginger, ice, vodka"]
        XCTAssertTrue(withOutLactoseCell.waitForExistence(timeout: 5))

        let lactoseCell = app.tables
            .buttons["Has lactose\nPotato and Cheese Frittata\ncheddar cheese, eggs, olive oil, onions, potato, salt"]
        XCTAssertTrue(lactoseCell.waitForExistence(timeout: 5))
    }

    func testRecipeDetail() {
        app.tables.buttons["Ginger Champagne\nchampagne, ginger, ice, vodka"].tap()
    }

    func testFavouriteList() {
        app.navigationBars["Recipes"].buttons["heart.fill"].tap()
    }

//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
