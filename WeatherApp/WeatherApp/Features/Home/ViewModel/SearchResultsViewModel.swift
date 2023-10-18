//
//  SearchResultsViewModel.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation
import MapKit
import Combine

final class SearchResultsViewModel: ObservableObject {

    @Published var searchText = ""
    var cancellable: AnyCancellable?

    init() {
        cancellable = $searchText.debounce(for: .seconds(0.25), scheduler: DispatchQueue.main)
            .sink { value in
                if !value.isEmpty && value.count > 3 {
                    self.search(text: value, region: LocationManager.shared.region)
                } else {
                    self.places = []
                }
            }
    }

    @Published var places = [PlaceModel]()

    func search(text: String, region: MKCoordinateRegion) {

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region

        let search = MKLocalSearch(request: searchRequest)

        search.start { response, error in

            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            self.places = response.mapItems.map(PlaceModel.init)
        }
    }
}

struct PlaceModel: Identifiable, Hashable {

    let id = UUID()
    private var mapItem: MKMapItem

    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }

    var name: String {
        mapItem.name ?? ""
    }

    var latitude: String {
        "\(mapItem.placemark.coordinate.latitude)"
    }

    var longitude: String {
        "\(mapItem.placemark.coordinate.longitude)"
    }

}
