//
//  Constants.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 16/10/23.
//

import Foundation

struct ViewControllerNames {
    static let weather = "weather_screen_title".localized
}

struct Api {
    static let baseURL = "api.openweathermap.org" // /data/2.5
    static let accessKey = "appid"
    static let accessValue = "9f0909426c2a03519703b672e9475c6c"
    static let latitudeKey = "lat"
    static let longitudeKey = "lon"
    static let unitsKey = "units"
    static let unitsValue = "metric"
}

struct ApiErrors {
    static let invalidURL = "invalid_url".localized
    static let invalidData = "invalid_data".localized
    static let noResponse = "no_response".localized
    static let genericError = "generic_error_message".localized
    static let noOfflineData = "no_offline_data".localized
}

struct WeatherScreen {
    static let deleteButtonTitle = "delete_button_title".localized
    static let listButtonTitle = "list_button_title".localized
    static let mapButtonTitle = "map_button_title".localized
    static let helpButtonTitle = "help_button_title".localized
    static let howToUseTitle = "how_to_use_app_title".localized
}

struct CityScreen {
    static let humidityTitle = "humidity_title".localized
    static let windSpeedTitle = "wind_speed_title".localized
    static let minTempTitle = "min_temp_title".localized
    static let maxTempTitle = "max_temp_title".localized
    static let feelsLikeTitle = "feels_like_title".localized
    static let pressureTitle = "pressure_title".localized
}

struct Forecast {
    static let next5daysTitle = "next_5_days_title".localized
    static let get5daysForecastTitle = "get_5_days_forecast_title".localized
}
