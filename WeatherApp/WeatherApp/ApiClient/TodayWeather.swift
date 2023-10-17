//
//  TodayWeather.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation

struct TodayWeather {
    let name: String
    let type: String
    let current: Double
    let high: Double
    let low: Double

    enum RootKeys: String, CodingKey {
        case name, weather, main
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
    }

}
