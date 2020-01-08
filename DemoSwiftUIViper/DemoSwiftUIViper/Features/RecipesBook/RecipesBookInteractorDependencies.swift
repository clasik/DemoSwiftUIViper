import Foundation

protocol RecipesBookInteractorDependenciesProtocol: APIServiceProvider, CoreDataServiceProvider {}

struct RecipesBookInteractorDependencies: RecipesBookInteractorDependenciesProtocol {
    let apiService: APIService
    let coreDataService: CoreDataService

    init() {
        apiService = APIService()
        coreDataService = CoreDataService()
    }
}
