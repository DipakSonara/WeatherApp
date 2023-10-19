//
//  CityScreenViewModel.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 18/10/23.
//

import Foundation
import Combine

final class CityScreenViewModel: ObservableObject {

    let todayWeatherObject: TodayWeather
    init(todayWeatherObject: TodayWeather) {
        self.todayWeatherObject = todayWeatherObject
    }

    /// Determine the background image to be loaded based on whether it's night or day time.
    var loadBackgroundImage: Bool {
        if self.todayWeatherObject.timeStamp >= self.todayWeatherObject.sunset {
            return false
        } else {
            return true
        }
    }

    /// Get the weather condition icon.
    var weatherIcon: String {
        let weatherDetail = self.todayWeatherObject.weatherDetail[0]
        switch weatherDetail.weatherIcon {
            case "01d":
                return "clear_sky_day"
            case "01n":
                return "clear_sky_night"
            case "02d":
                return "few_clouds_day"
            case "02n":
                return "few_clouds_night"
            case "03d":
                return "scattered_clouds"
            case "03n":
                return "scattered_clouds"
            case "04d":
                return "broken_clouds"
            case "04n":
                return "broken_clouds"
            case "09d":
                return "shower_rain"
            case "09n":
                return "shower_rain"
            case "10d":
                return "rain_day"
            case "10n":
                return "rain_night"
            case "11d":
                return "thunderstorm_day"
            case "11n":
                return "thunderstorm_night"
            case "13d":
                return "snow"
            case "13n":
                return "snow"
            case "50d":
                return "mist"
            case "50n":
                return "mist"
            default:
                return "clear_sky_day"
        }

    }

    /// Get the date returned by the API
    var date: String {
        return self.dateFormatter(timeStamp: self.todayWeatherObject.timeStamp)
    }

    /// Get the temperature
    var temperature: String {
        return String(format: "%.1f", self.todayWeatherObject.current)
    }

    /// Get the min temp.
    var tempMin: String {
        return String(format: "%.1f", self.todayWeatherObject.low)
    }

    /// Get the max temp
    var tempMax: String {
        return String(format: "%.1f", self.todayWeatherObject.high)
    }

    /// Get the sunrise date
    var sunrise: String {
        return self.getTime(timeStamp: self.todayWeatherObject.sunrise)
    }

    /// Get the sunset date
    var sunset: String {
        return self.getTime(timeStamp: self.todayWeatherObject.sunset)
    }

    var weatherType: String {
        return self.todayWeatherObject.weatherDetail[0].weatherType
    }

    /// The the current time in 12-hour format with the right timezone (e.g. 5:52 AM)
    private func getTime(timeStamp: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = TimeZone(secondsFromGMT: self.todayWeatherObject.timezone)
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }

    /// Format the date properly (e.g. Monday, May 11, 2020)
    private func dateFormatter(timeStamp: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
}
