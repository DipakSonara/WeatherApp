//
//  TodayWeather.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation

struct TodayWeather: Hashable, Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let current: Double
    let high: Double
    let low: Double
    let lat: Double
    let lon: Double

    enum RootKeys: String, CodingKey {
        case name, weather, main, coord
    }

    enum CoordKeys: String, CodingKey {
        case lat, lon
    }

    enum WeatherKeys: String, CodingKey {
        case type = "description"
    }

    enum MainKeys: String, CodingKey {
        case current = "temp"
        case high = "temp_min"
        case low = "temp_max"
    }
}

extension TodayWeather: Codable {

    init(from decoder: Decoder) throws {
        // id
        let container = try decoder.container(keyedBy: RootKeys.self)
        name = try container.decode(String.self, forKey: .name)

        // weather
        //let weatherContainer = try container.decode([WeatherKeys.self], forKey: .weather)
        //type = try weatherContainer.decode(String.self, forKey: .type)
        type = ""
        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        current = try mainContainer.decode(Double.self, forKey: .current)
        high = try mainContainer.decode(Double.self, forKey: .high)
        low = try mainContainer.decode(Double.self, forKey: .low)

        let coordContainer = try container.nestedContainer(keyedBy: CoordKeys.self, forKey: .coord)
        lat = try coordContainer.decode(Double.self, forKey: .lat)
        lon = try coordContainer.decode(Double.self, forKey: .lon)
    }

}

extension TodayWeather {
    static let sampleData: [TodayWeather] =
    [
        TodayWeather(name: "Ahmedabad",
                     type: "Clear Sky",
                     current: 35.0,
                     high: 40.0,
                     low: 30.0,
                     lat: 71.00,
                     lon: 81.00),
        TodayWeather(name: "Ahmedabad",
                     type: "Clear Sky",
                     current: 35.0,
                     high: 40.0,
                     low: 30.0,
                     lat: 71.00,
                     lon: 81.00),
        TodayWeather(name: "Ahmedabad",
                     type: "Clear Sky",
                     current: 35.0,
                     high: 40.0,
                     low: 30.0,
                     lat: 71.00,
                     lon: 81.00),
        TodayWeather(name: "Ahmedabad",
                     type: "Clear Sky",
                     current: 35.0,
                     high: 40.0,
                     low: 30.0,
                     lat: 71.00,
                     lon: 81.00),
        TodayWeather(name: "Ahmedabad",
                     type: "Clear Sky",
                     current: 35.0,
                     high: 40.0,
                     low: 30.0,
                     lat: 71.00,
                     lon: 81.00),
    ]
}
