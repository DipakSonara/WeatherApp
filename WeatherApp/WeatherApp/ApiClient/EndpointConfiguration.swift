//
//  EndpointConfiguration.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 25/10/23.
//

import Foundation

public enum Method: String {
    case GET
    case PUT
    case POST
    case DELETE
}

public protocol EndpointConfiguration {
    var path: String { get }
    var method: Method { get }
    var scheme: String { get }
    var queryParameters: [URLQueryItem]? { get }
    var body: Encodable? { get }
}
