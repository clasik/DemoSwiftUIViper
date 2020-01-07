import XCTest
import SnapshotTesting
import UIKit
import SwiftUI

@testable import DemoSwiftUIViper

class RecipeCellViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBodyExists() {
        let sut = RecipeCellView(recipe: RecipeViewModel(title: "Title",
                                                         href: "http://allrecipes.com/Recipe/Ginger-Champagne/Detail.aspx",
                                                         ingredients: "Ingredients",
                                                         thumbnail: "http://img.recipepuppy.com/285514.jpg",
                                                         favourite: false,
                                                         hasLactose: false), onFavouriteTapGasture: {
        })
        XCTAssertNotNil(sut.body)
    }
    
    func testSnapShotWithoutLactose(){
        let sut = RecipeCellView(recipe: RecipeViewModel(title: "Title",
                                                         href: "http://allrecipes.com/Recipe/Ginger-Champagne/Detail.aspx",
                                                         ingredients: "Ingredients",
                                                         thumbnail: "http://img.recipepuppy.com/285514.jpg",
                                                         favourite: false,
                                                         hasLactose: false), onFavouriteTapGasture: {
        })
        let scale = String(Int(Float(UIScreen.main.scale)))
        ColorScheme.allCases.forEach { scheme in
            let hostingController = UIHostingController(rootView: sut.colorScheme(scheme))
            let name = "\(UIDevice.current.model)-\(scale)-\(scheme)"
            hostingController.view.backgroundColor = .clear
            assertSnapshot(matching: hostingController,
                           as: .image(size: CGSize(width: 300, height: 300)),
                           named: name,
                           record: false,
                           timeout: 5,
                           file: #file,
                           testName: #function,
                           line: #line)
        }
    }
    
    func testSnapShotWithLactose(){
        let sut = RecipeCellView(recipe: RecipeViewModel(title: "Title",
                                                         href: "http://allrecipes.com/Recipe/Ginger-Champagne/Detail.aspx",
                                                         ingredients: "Ingredients",
                                                         thumbnail: "http://img.recipepuppy.com/285514.jpg",
                                                         favourite: true,
                                                         hasLactose: true), onFavouriteTapGasture: {
        })
        let scale = String(Int(Float(UIScreen.main.scale)))
        ColorScheme.allCases.forEach { scheme in
            let hostingController = UIHostingController(rootView: sut.colorScheme(scheme))
            let name = "\(UIDevice.current.model)-\(scale)-\(scheme)"
            hostingController.view.backgroundColor = .clear
            assertSnapshot(matching: hostingController,
                           as: .image(size: CGSize(width: 300, height: 300)),
                           named: name,
                           record: false,
                           timeout: 5,
                           file: #file,
                           testName: #function,
                           line: #line)
        }
    }
    
}
