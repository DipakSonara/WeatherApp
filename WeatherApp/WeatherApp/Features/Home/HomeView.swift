//
//  HomeView.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            viewModel.getCurrentWeatherFrom(cityName: "Ahmedabad")
        }
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
