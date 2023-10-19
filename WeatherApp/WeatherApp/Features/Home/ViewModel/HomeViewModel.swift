//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation
import Combine
import CoreLocation

final class HomeViewModel: ObservableObject {

    private let api = ApiClient()
    private var cancellables = Set<AnyCancellable>()
    @Published var currentWeatherData: [TodayWeather] = []

    func getCurrentWeatherFrom(lat: String, lon: String) {
        var weatherData = getSavedWeatherData()
        self.api.getCurrentWeather(lat: lat, lon: lon)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }
            receiveValue: { [weak self] currentData in
                weatherData.append(currentData)
                self?.currentWeatherData.append(currentData)
                self?.saveWeatherData(weatherData: weatherData)
            }
            .store(in: &self.cancellables)
            }

    func getSavedWeatherData() -> [TodayWeather] {
        if let objects = UserDefaults.standard.object(forKey: "WeatherData") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode([TodayWeather].self, from: objects) as [TodayWeather] {
                return objectsDecoded
            } else {
                return []
            }
        } else {
            return []
        }
    }

    private func saveWeatherData(weatherData: [TodayWeather]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(weatherData){
            UserDefaults.standard.set(encoded, forKey: "WeatherData")
            UserDefaults.standard.synchronize()
        }
    }
}
