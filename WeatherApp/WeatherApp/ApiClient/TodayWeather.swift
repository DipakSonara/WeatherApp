//
//  TodayWeather.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation

// MARK: - TodayWeather
struct TodayWeather: Codable, Identifiable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}


// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    let seaLevel: Int?
    let grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

extension TodayWeather {
    static let sampleData: [TodayWeather] =
    [
        TodayWeather(coord: Coord(lon: 71.00, lat: 81.00),
                     weather: [Weather(id: 804,
                                       main: "Clouds",
                                       description: "Overcast clouds",
                                       icon: "04d")],
                     base: "stations",
                     main: Main(temp: 25.61,
                                feelsLike: 25.61,
                                tempMin: 25.61,
                                tempMax: 25.61,
                                pressure: 1014,
                                humidity: 81,
                                seaLevel: 1015,
                                grndLevel: 933),
                     visibility: 10000,
                     wind: Wind(speed: 196, deg: 40, gust:1.18),
                     rain: Rain(the1H: 1.0),
                     clouds: Clouds(all: 100),
                     dt: 1697627681,
                     sys: Sys(type: 1, id: 9049, country: "IN", sunrise: 1697607702, sunset: 1697651306),
                     timezone: 0,
                     id: 6295630,
                     name: "Globe",
                     cod: 200)
    ]
}

enum Unit: String {
    case metric = "metric"
    case imperial = "imperial"
}

struct WeatherRequest {
    let latitude: String
    let longitude: String
    let unit: Unit
}
