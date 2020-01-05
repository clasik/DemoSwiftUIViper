import Foundation

protocol RecipesBookInteractorDependenciesProtocol: APIServiceProvider {}

struct RecipesBookInteractorDependencies: RecipesBookInteractorDependenciesProtocol {
    let apiService: APIService

    init() {
        apiService = APIService()
    }
}
