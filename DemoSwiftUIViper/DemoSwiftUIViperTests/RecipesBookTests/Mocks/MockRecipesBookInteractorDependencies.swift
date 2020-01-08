import Foundation
@testable import DemoSwiftUIViper

struct MockRecipesBookInteractorDependencies: RecipesBookInteractorDependenciesProtocol {
    let apiService: APIService
    let coreDataService: CoreDataService

    class Foo {}

    init() {
        let bundle = Bundle(for: MockRecipesBookInteractorDependencies.Foo.self)
        let path = bundle.path(forResource: "MockRecipesBook", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        apiService = APIService(url: url)
        coreDataService = CoreDataService()
    }
}
