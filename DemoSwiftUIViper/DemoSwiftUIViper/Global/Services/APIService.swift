import Combine
import Foundation

protocol APIServiceProvider {
    var apiService: APIService { get }
}

final class APIService {
    private let baseURL: URL
    private let urlSession: URLSession = .shared
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    init(url: URL = URL(string: "http://www.recipepuppy.com/api/")!){
        self.baseURL = url
    }

    func getRecipes(page: Int, ingredients: String) -> AnyPublisher<RecipesBookResponseModel, Error> {
        let queryItemPage = URLQueryItem(name: "p", value: "\(page)")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [queryItemPage]
        if !ingredients.isEmpty {
            let queryItemIngredients = URLQueryItem(name: "i", value: ingredients)
            urlComponents?.queryItems?.append(queryItemIngredients)
        }
        guard let url = urlComponents?.url else {
            return Fail(error: APIServiceError.couldNotCreateURL).eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
        debugPrint(urlRequest)
        return urlSession.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: RecipesBookResponseModel.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
