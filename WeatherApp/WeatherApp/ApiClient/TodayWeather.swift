//
//  TodayWeather.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation

struct TodayWeather: Identifiable {
    
    var id = UUID()
    let name: String
    let weatherDetail: [WeatherDetail]
    let current: Double
    let high: Double
    let low: Double
    let lat: Double
    let lon: Double
    let humidity: Double
    let feelsLike: Double
    let pressure: Int
    let windSpeed: Double
    let sunrise: Int
    let sunset: Int
    let timeStamp: Int
    let timezone: Int

    enum RootKeys: String, CodingKey {
        case name, weatherDetail = "weather", main, coord, wind, sys, timeStamp = "dt", timezone
    }

    enum CoordKeys: String, CodingKey {
        case lat, lon
    }

    enum MainKeys: String, CodingKey {
        case current = "temp"
        case high = "temp_min"
        case low = "temp_max"
        case humidity = "humidity"
        case feelsLike = "feels_like"
        case pressure = "pressure"
    }

    enum WindKeys: String, CodingKey {
        case windSpeed = "speed"
    }

    enum SysKeys: String, CodingKey {
        case sunrise = "sunrise"
        case sunset = "sunset"
    }

    var loadBackgroundImage: Bool {
        timeStamp <= sunset
    }
}

extension TodayWeather: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        name = try container.decode(String.self, forKey: .name)
        weatherDetail = try container.decode([WeatherDetail].self, forKey: .weatherDetail)
        timeStamp = try container.decode(Int.self, forKey: .timeStamp)
        timezone = try container.decode(Int.self, forKey: .timezone)

        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        current = try mainContainer.decode(Double.self, forKey: .current)
        high = try mainContainer.decode(Double.self, forKey: .high)
        low = try mainContainer.decode(Double.self, forKey: .low)
        humidity = try mainContainer.decode(Double.self, forKey: .humidity)
        feelsLike = try mainContainer.decode(Double.self, forKey: .feelsLike)
        pressure = try mainContainer.decode(Int.self, forKey: .pressure)

        let coordContainer = try container.nestedContainer(keyedBy: CoordKeys.self, forKey: .coord)
        lat = try coordContainer.decode(Double.self, forKey: .lat)
        lon = try coordContainer.decode(Double.self, forKey: .lon)

        let windContainer = try container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        windSpeed = try windContainer.decode(Double.self, forKey: .windSpeed)

        let sysContainer = try container.nestedContainer(keyedBy: SysKeys.self, forKey: .sys)
        sunrise = try sysContainer.decode(Int.self, forKey: .sunrise)
        sunset = try sysContainer.decode(Int.self, forKey: .sunset)
    }
}

struct WeatherDetail {
    let id: Int
    let weatherType: String
    let weatherDescription: String
    let weatherIcon: String

    enum WeatherKeys: String, CodingKey {
        case id
        case weatherType = "main"
        case weatherDescription = "description"
        case weatherIcon = "icon"
    }
}

extension WeatherDetail: Codable {
    init(from decoder: Decoder) throws {
        let weatherContainer = try decoder.container(keyedBy: WeatherKeys.self)
        id = try weatherContainer.decode(Int.self, forKey: .id)
        weatherType = try weatherContainer.decode(String.self, forKey: .weatherType)
        weatherDescription = try weatherContainer.decode(String.self, forKey: .weatherDescription)
        weatherIcon = try weatherContainer.decode(String.self, forKey: .weatherIcon)
    }
}

extension TodayWeather {
    static let sampleData: [TodayWeather] =
    [
        TodayWeather(name: "Ahmedabad",
                     weatherDetail: [WeatherDetail(id: 804,
                                                   weatherType: "Clouds",
                                                   weatherDescription: "overcast clouds",
                                                   weatherIcon: "04d")],
                     current: 25.61,
                     high: 25.61,
                     low: 25.61,
                     lat: 71.00,
                     lon: 81.00,
                     humidity: 81,
                     feelsLike: 26.34,
                     pressure: 1014,
                     windSpeed: 2.83,
                     sunrise: 1697607702,
                     sunset: 1697651306,
                     timeStamp: 1697627681,
                     timezone:0)
    ]
}
