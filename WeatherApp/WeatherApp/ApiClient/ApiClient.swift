//
//  ApiClient.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 16/10/23.
//

import Foundation
import Combine
import Network

protocol ApiProvider {
    // get today's/five days weather for given city name
    func getWeather<T:Codable>(forEndPoint: Endpoint, lat: Double, lon: Double, type:T.Type) -> Future<T, Error>
}

enum Endpoint {

    case today
    case weekly

    var path: String {
        switch self {
        case .today:
            return "/data/2.5/weather"
        case .weekly:
            return "/data/2.5/forecast"
        }
    }

    var scheme: String {
        return "http"
    }
}

final class ApiClient: ApiProvider {

    public private(set) var hasInternet = true
    private let networkMonitor = NWPathMonitor()
    private let networkMonitorQueue = DispatchQueue(label: "APIClient.networkMonitor")
    private var cancellables = Set<AnyCancellable>()



    private enum Method: String {
        case GET
        case PUT
        case POST
        case DELETE
    }

    fileprivate let defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60.0
        configuration.timeoutIntervalForResource = 60.0
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()

    init(hasInternet: Bool = true) {
        self.hasInternet = hasInternet
        monitorNetwork()
    }

    private func request<T: Decodable>(type: T.Type,
                                       endpoint:Endpoint,
                                       method:Method,
                                       queryItems: [URLQueryItem]) -> Future<T, Error> {

        return Future<T, Error> { [weak self] promise in

            var urlComponents = URLComponents()
            urlComponents.scheme = endpoint.scheme
            urlComponents.host = Api.baseURL
            urlComponents.path = endpoint.path
            urlComponents.queryItems = queryItems

            guard let self = self, let url = urlComponents.url else {
                return promise(.failure(ApiError.invalidURL))
            }

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue

            self.defaultSession.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw ApiError.noResponse
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as ApiError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(ApiError.genericError))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }

    private func monitorNetwork() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.hasInternet = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: networkMonitorQueue)
    }
}

extension ApiClient {
    func getWeather<T:Codable>(forEndPoint: Endpoint, lat: Double, lon: Double, type:T.Type) -> Future<T, Error> {
        var accessKeyQueryItem: URLQueryItem {
            return URLQueryItem(name: Api.accessKey,
                                value: Api.accessValue)
        }

        var latitudeQueryItem: URLQueryItem {
            return URLQueryItem(name: Api.latitudeKey,
                                value: "\(lat)")
        }

        var longitudeQueryItem: URLQueryItem {
            return URLQueryItem(name: Api.longitudeKey,
                                value: "\(lon)")
        }

        var unitsQueryItem: URLQueryItem {
            return URLQueryItem(name: Api.unitsKey,
                                value: Api.unitsValue)
        }
        return request(type: type,
                endpoint: forEndPoint,
                method: .GET,
                queryItems: [latitudeQueryItem,
                             longitudeQueryItem,
                             accessKeyQueryItem,
                             unitsQueryItem])
    }
}


enum ApiError: Error {
    case invalidURL
    case invalidData
    case noResponse
    case genericError
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return ApiErrors.invalidURL
        case .invalidData: return ApiErrors.invalidData
        case .noResponse: return ApiErrors.noResponse
        case .genericError: return ApiErrors.genericError
        }
    }
}
