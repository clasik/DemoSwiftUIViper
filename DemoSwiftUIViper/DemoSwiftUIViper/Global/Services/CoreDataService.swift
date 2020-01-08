import Combine
import CoreData
import Foundation
import UIKit

protocol CoreDataServiceProvider {
    var coreDataService: CoreDataService { get }
}

final class CoreDataService {
    func getRecipes() -> ReversedCollection<[Any]>? {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Recipe")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do {
            let fetchedObjects = try context.fetch(fetchRequest).reversed()
            return fetchedObjects
        } catch {
            debugPrint(error)
        }
        return nil
    }

    func checkIsFavourite(recipe: RecipeDataModel) -> Bool {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Recipe")
        fetchRequest.predicate = NSPredicate(format: "title == %@", recipe.title)
        do {
            let result = try context.fetch(fetchRequest)
            return result.count > 0
        } catch {
            debugPrint(error)
        }
        return false
    }

    func makeFavourite(recipe: RecipeDataModel) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        if checkIsFavourite(recipe: recipe) {
            _ = deleteRecipe(recipe: recipe)
            return
        }

        let newRecipe = Recipe(context: context)
        newRecipe.title = recipe.title
        newRecipe.href = recipe.href
        newRecipe.thumbnail = recipe.thumbnail
        newRecipe.ingredients = recipe.ingredients

        do {
            try context.save()
        } catch {
            debugPrint(error)
        }
    }

    func deleteRecipe(recipe: RecipeDataModel) -> Bool {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Recipe")
        fetchRequest.predicate = NSPredicate(format: "title == %@", recipe.title)
        do {
            let result = try context.fetch(fetchRequest)
            result.forEach { object in
                if let object = object as? NSManagedObject {
                    context.delete(object)
                }
            }
            try context.save()
            return result.count > 0
        } catch {
            debugPrint(error)
        }
        return false
    }
}
