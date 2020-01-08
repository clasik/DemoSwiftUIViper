enum RecipesBookDataModelConvertibleError: Error {
    case missingTitle
    case missingHref
    case missingVersion
    case missingResults
}
