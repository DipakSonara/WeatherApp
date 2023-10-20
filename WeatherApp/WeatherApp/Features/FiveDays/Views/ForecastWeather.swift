//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 19/10/23.
//

import Foundation
import SwiftUI

struct ForecastWeather: View {
    @ObservedObject var forecastViewModel = ForecastViewModel()

    let lat: Double
    let lon: Double

    var body: some View {
        NavigationView {
            List(self.forecastViewModel.forecastResponse.list, id: \.dt) { forecast in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(self.forecastViewModel.dateFormatter(timeStamp: forecast.dt!))")
                            .font(.footnote)
                            .foregroundColor(Color.primary)
                        Text("\(self.forecastViewModel.getTime(timeStamp: forecast.dt!))")
                            .font(.footnote)
                            .foregroundColor(Color.secondary)
                        Text("\(self.forecastViewModel.city)")
                            .font(.footnote).foregroundColor(Color.gray)
                        Text("\(forecast.weather?[0].description ?? "")".capitalized)
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color.blue)
                            .padding(.top, 20)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        HStack {
                            Image("\(self.forecastViewModel.getWeatherIcon(icon_name: (forecast.weather?[0].icon)!))")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                            Text("\(self.forecastViewModel.formatDouble(temp: (forecast.main?.temp) ?? 0.0))°C")
                                .foregroundColor(Color.primary)
                        }
                    }
                }
                .padding(.vertical, 10)
            }
            .onAppear() {
                self.forecastViewModel.getFiveDayWeatherFrom(lat: lat, lon: lon)
            }
            .navigationTitle(Forecast.next5daysTitle)
        }
    }
}

struct ForecastWeather_Previews: PreviewProvider {
    static var previews: some View {
        ForecastWeather(lat: 0.0, lon: 0.0)
    }
}

