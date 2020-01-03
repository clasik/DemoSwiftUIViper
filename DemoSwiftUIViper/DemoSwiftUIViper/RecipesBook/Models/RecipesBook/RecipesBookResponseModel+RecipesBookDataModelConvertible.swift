import Foundation

extension RecipesBookResponseModel: RecipesBookDataModelConvertible {
    func recipesBookDataModel() throws -> RecipesBookDataModel {
        guard let title = title else {
            throw RecipesBookDataModelConvertibleError.missingTitle
        }
        guard let href = href else {
            throw RecipesBookDataModelConvertibleError.missingHref
        }
        guard let version = version else {
            throw RecipesBookDataModelConvertibleError.missingVersion
        }
        guard let results = results else {
            throw RecipesBookDataModelConvertibleError.missingResults
        }
        return RecipesBookDataModel(title: title, version: version, href: href, results: results)
    }
}
