//
//  MKCoordinateRegion+Extensions.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation
import MapKit

extension MKCoordinateRegion {

    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 29.726819, longitude: -95.393692), latitudinalMeters: 100, longitudinalMeters: 100)
    }

}
