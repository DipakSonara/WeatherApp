//
//  HomeView.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation
import SwiftUI
import MapKit

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @StateObject private var locationManager = LocationManager.shared
    @StateObject private var searchViewModel = SearchResultsViewModel()
    @State private var search = ""
    @State private var showMap = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(
                                                                latitude: LocationManager.shared.location?.coordinate.latitude ?? 0.0,
                                                                longitude: LocationManager.shared.location?.coordinate.longitude ?? 0.0),
                                                   span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

    var body: some View {
        NavigationView {
            if showMap {
                Map(coordinateRegion: $region, annotationItems: viewModel.currentWeatherData) {
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon))
                        
                }
                .navigationTitle(ViewControllerNames.weather)
                .toolbar {
                    Button(WeatherScreen.listButtonTitle) {
                        showMap = false
                    }
                }
            } else {
                List {
                    if searchViewModel.searchText.count != 0 {
                        ForEach(searchViewModel.places, id: \.self) { place in
                            Text(place.name)
                                .onTapGesture {
                                    viewModel.getCurrentWeatherFrom(lat: place.latitude, lon: place.longitude)
                                    searchViewModel.searchText = ""
                                }
                        }
                    } else {
                        ForEach(viewModel.currentWeatherData, id: \.self) { weatherData in
                            CardView(weather: weatherData)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive, action: { viewModel.currentWeatherData.remove(at: 0) } ) {
                                Label(WeatherScreen.deleteButtonTitle, systemImage: "trash")
                              }
                        }
                    }
                }
                .searchable(text: $searchViewModel.searchText)
                .onAppear {
                    //viewModel.currentWeatherData = viewModel.getSavedWeatherData()
                }
                .navigationTitle(ViewControllerNames.weather)
                .toolbar {
                    Button(WeatherScreen.mapButtonTitle) {
                        showMap = true
                    }
                }
            }

        }

    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
