//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 16/10/23.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}
