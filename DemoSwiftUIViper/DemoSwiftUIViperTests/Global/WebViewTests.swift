import XCTest
@testable import DemoSwiftUIViper

class WebViewTests: XCTestCase {
    
    var sut: WebView!
    
    override func setUp() {
        super.setUp()
        sut = WebView(request: URLRequest(url: URL(string: "http://allrecipes.com/Recipe/Ginger-Champagne/Detail.aspx")!))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBodyExists() {
        XCTAssertNotNil(sut)
    }
    
}

