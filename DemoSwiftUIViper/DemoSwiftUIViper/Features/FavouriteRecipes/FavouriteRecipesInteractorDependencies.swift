import Foundation

protocol FavouriteRecipesInteractorDependenciesProtocol: CoreDataServiceProvider {}

struct FavouriteRecipesInteractorDependencies: FavouriteRecipesInteractorDependenciesProtocol {
    let coreDataService: CoreDataService

    init() {
        coreDataService = CoreDataService()
    }
}
