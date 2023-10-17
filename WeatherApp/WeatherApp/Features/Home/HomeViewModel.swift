//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation
import Combine
import CoreLocation

class HomeViewModel: ObservableObject {

    private let api = ApiClient()

    func getCurrentWeatherFrom(cityName: String) {
        getCoordinateFrom(cityName: cityName) { [weak self] coordinate, error in
            guard let self = self else { return }
            guard let coordinate = coordinate, error == nil else { return }

            self.api.getCurrentWeather(lat: "\(coordinate.latitude)", lon: "\(coordinate.longitude)") { (result) in

            }
        }
    }
}

extension HomeViewModel {
    private func getCoordinateFrom(cityName: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(cityName) { completion($0?.first?.location?.coordinate, $1) }
    }
}
