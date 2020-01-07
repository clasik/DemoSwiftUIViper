import XCTest
import Combine
@testable import DemoSwiftUIViper

class RecipesBookPresenterTests: XCTestCase {
    
    var sut: RecipesBookPresenter!
    var interactor: RecipesBookInteractor!
    
    override func setUp() {
        super.setUp()
        let interactorDependencies = MockRecipesBookInteractorDependencies()
        interactor = RecipesBookInteractor(dependencies: interactorDependencies)
        
        let presenterDependencies = RecipesBookPresenterDependencies()
        sut = RecipesBookPresenter(dependencies: presenterDependencies, interactor: interactor)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEventsPresenter() {
        
        sut.didReceiveEvent(.viewAppears)
        
//        let publisher = sut.getCurrentRecipes()
//        let validTest = evalValidResponseTest(publisher: publisher)
//        wait(for: validTest.expectations, timeout:3)
//        validTest.cancellable?.cancel()
        
        
        sut.didReceiveEvent(.viewDisappears)
        
        do {
            sleep(2)

            var cancellableSet = Set<AnyCancellable>()
//            sut.$recipeViewModels.sink(receiveValue: { values in
//                //XCTAssertTrue(values.count > 0)
//                XCTAssertTrue(self.sut.recipeViewModels.count > 0)
//            })
//                .store(in: &cancellableSet)
            
            sut.$recipeViewModels
                .sink(receiveCompletion: { values in
                    XCTAssertTrue(self.sut.recipeViewModels.count > 0)
                }) { recipeDataModels in
                    XCTAssertTrue(recipeDataModels.count > 0)
            }.store(in: &cancellableSet)
        }
    }
    
    func testActionsPresenter() {
        let item = RecipeViewModel(title: "title",
                                   href: "http://allrecipes.com/Recipe/Eggnog-Thumbprints/Detail.aspx",
                                   ingredients: "ingredients",
                                   thumbnail: "http://img.recipepuppy.com/3.jpg",
                                   favourite: true, hasLactose: true)
        sut.didTriggerAction(.makeFavourite(item))
        
        sut.didTriggerAction(.nextPage)
        
        sut.didTriggerAction(.retry)
        
        sut.didTriggerAction(.updateIngredients("ingredients"))
    }
}


