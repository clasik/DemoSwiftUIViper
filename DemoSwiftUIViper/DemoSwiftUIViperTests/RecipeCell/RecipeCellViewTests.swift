import XCTest
import SnapshotTesting
import UIKit
import SwiftUI

@testable import DemoSwiftUIViper

class RecipeCellViewTests: XCTestCase {
    let title = "Title"
    let href = "http://allrecipes.com/Recipe/Ginger-Champagne/Detail.aspx"
    let ingredients = "Ingredients"
    let thumbnail = "http://img.recipepuppy.com/285514.jpg"

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBodyExists() {
        let sut = RecipeCellView(recipe: RecipeViewModel(title: title,
                                                         href: href,
                                                         ingredients: ingredients,
                                                         thumbnail: thumbnail,
                                                         favourite: false,
                                                         hasLactose: false), onFavouriteTapGasture: {
        })
        XCTAssertNotNil(sut.body)
    }

    func testSnapShotWithoutLactose() {
        let sut = RecipeCellView(recipe: RecipeViewModel(title: title,
                                                         href: href,
                                                         ingredients: ingredients,
                                                         thumbnail: thumbnail,
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

    func testSnapShotWithLactose() {
        let sut = RecipeCellView(recipe: RecipeViewModel(title: title,
                                                         href: href,
                                                         ingredients: ingredients,
                                                         thumbnail: thumbnail,
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
