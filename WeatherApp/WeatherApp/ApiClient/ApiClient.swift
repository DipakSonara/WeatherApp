//
//  ApiClient.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 16/10/23.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case invalidData
    case noResponse
    case genericError

    var message: String {
        switch self {
        case .invalidURL: return ApiErrors.invalidURL
        case .invalidData: return ApiErrors.invalidData
        case .noResponse: return ApiErrors.noResponse
        case .genericError: return ApiErrors.genericError
        }
    }
}

protocol ApiProvider {
    // get today's weather for given city name
    func getCurrentWeather(lat: String, lon: String, completion: @escaping (Result<TodayWeather, ApiError>) -> ())
}

final class ApiClient: ApiProvider {

    enum Endpoint {

        case today
        case weekly(coordinates: String)

        var path: String {
            switch self {
            case .today:
                return "/data/2.5/weather"
            case .weekly(let coordinates):
                return "/data/2.5/forecast?\(coordinates)"
            }
        }

        var scheme: String {
            return "http"
        }
    }

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

    private func request<T: Codable>(endpoint:Endpoint,
                                     method:Method,
                                     queryItems: [URLQueryItem],
                                     completion: @escaping((Result<T,ApiError>) -> Void)) {

        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = Api.baseURL
        urlComponents.path = endpoint.path
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        print(url)
        self.call(with: request, completion: completion)
    }

    private func call<T: Codable>(with request: URLRequest,
                                      completion: @escaping((Result<T,ApiError>) -> Void)) {
            let dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
                guard error == nil else { completion(.failure(.invalidData)); return }

                guard
                    let responseData = data,
                    let httpResponse = response as? HTTPURLResponse,
                    200 ..< 300 ~= httpResponse.statusCode else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let jsonDecoder = JSONDecoder()
                    let genericModel = try jsonDecoder.decode(T.self, from: responseData)
                    completion(.success(genericModel))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
            dataTask.resume()
    }
}

extension ApiClient {
    func getCurrentWeather(lat: String,
                           lon: String,
                           completion: @escaping (Result<TodayWeather, ApiError>) -> ()) {
        var accessKeyQueryItem: URLQueryItem {
            return URLQueryItem(name: Api.accessKey,
                                value: Api.accessValue)
        }

        var latitudeQueryItem: URLQueryItem {
            return URLQueryItem(name: Api.latitudeKey,
                                value: lat)
        }

        var longitudeQueryItem: URLQueryItem {
            return URLQueryItem(name: Api.longitudeKey,
                                value: lon)
        }

        var unitsQueryItem: URLQueryItem {
            return URLQueryItem(name: Api.unitsKey,
                                value: Api.unitsValue)
        }
        request(endpoint: .today,
                method: .GET,
                queryItems: [latitudeQueryItem,
                             longitudeQueryItem,
                             accessKeyQueryItem,
                             unitsQueryItem],
                completion: completion)
    }

//    func getListOfCurrencies(completion: @escaping (Result<CurrencyListModel, ApiError>) -> ()) {
//        request(endpoint: .list, method: .GET, completion: completion)
//    }
}

