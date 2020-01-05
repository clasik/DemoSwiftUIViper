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

    private var subscriptions = Set<AnyCancellable>()

    func fetchMovies(page: Int, ingredients: String) -> Future<[RecipesBookResponseModel], Error> {
        return Future<[RecipesBookResponseModel], Error> {[unowned self] _ in
            let queryItemPage = URLQueryItem(name: "p", value: "\(page)")
            var urlComponents = URLComponents(url: self.baseURL, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = [queryItemPage]
            if !ingredients.isEmpty {
                let queryItemIngredients = URLQueryItem(name: "i", value: ingredients)
                urlComponents?.queryItems?.append(queryItemIngredients)
            }
            let urlRequest = URLRequest(url: urlComponents!.url!)
            debugPrint(urlRequest)

            self.urlSession.dataTaskPublisher(for: urlRequest)
                .tryMap { (data, _) -> Data in
//                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
//                        //throw Fail<Any, String>(error: APIServiceError.couldNotCreateURL)//Error.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
//                        
//                    }
                    return data
            }
            .decode(type: RecipesBookResponseModel.self, decoder: self.jsonDecoder)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (_) in
//                if case let .failure(error) = completion {
//                    switch error {
//                    case let urlError as URLError:
//                        promise(.failure(.urlError(urlError)))
//                    case let decodingError as DecodingError:
//                        promise(.failure(.decodingError(decodingError)))
//                    case let apiError as MovieStoreAPIError:
//                        promise(.failure(apiError))
//                    default:
//                        promise(.failure(.genericError))
//                    }
//                }
            }, receiveValue: {_ in /* promise(.success($0.results))*/ })
                .store(in: &self.subscriptions)
        }
    }
}
