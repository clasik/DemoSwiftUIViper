import XCTest

class DemoSwiftUIViperUITests: XCTestCase {

    func testExample() {
        let app = XCUIApplication()
        app.launch()

    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
