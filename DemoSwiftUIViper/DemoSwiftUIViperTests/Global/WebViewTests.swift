import XCTest
@testable import DemoSwiftUIViper

class WebViewTests: XCTestCase {

    var sut: WebView!

    override func setUp() {
        super.setUp()
        let url = URL(string: "http://allrecipes.com/Recipe/Ginger-Champagne/Detail.aspx")
        sut = WebView(request: URLRequest(url: url!))
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBodyExists() {
        XCTAssertNotNil(sut)
    }

}
