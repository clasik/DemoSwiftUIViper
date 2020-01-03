import Combine
import Foundation

protocol APIServiceProvider {
    var apiService: APIService { get }
}

final class APIService {
    private let baseURL = URL(string: "http://www.recipepuppy.com/api/")!
    private let urlSession: URLSession = .shared
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    func getRecipes(page: Int, ingredients: String) -> AnyPublisher<RecipesBookResponseModel, Error> {
        let queryItemPage = URLQueryItem(name: "p", value: "\(page)")
        let queryItemIngredients = URLQueryItem(name: "i", value: ingredients)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [queryItemPage, queryItemIngredients]
        guard let url = urlComponents?.url else {
            return Fail(error: APIServiceError.couldNotCreateURL).eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
        return urlSession.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: RecipesBookResponseModel.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
