//
//  CardView.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation
import SwiftUI

struct CardView: View {
    let todayWeather: TodayWeather

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("\(todayWeather.name)")
                    .font(.headline)
                    .foregroundColor(Color.primary)
                Spacer()
                if let weatherDetail = todayWeather.weather.first {
                    Text(weatherDetail.main)
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                }
            }
            Spacer()
            VStack {
                Text("\(Int(todayWeather.main.temp))℃")
                    .font(.title)
                    .foregroundColor(Color.primary)
                Spacer()
                Text("H:\(Int(todayWeather.main.tempMax))℃  L:\(Int(todayWeather.main.tempMin))℃")
                    .font(.headline)
                    .foregroundColor(Color.secondary)
            }
        }
        .frame(height: 70.0)
    }
}

struct CardView_Previews: PreviewProvider {
    static var weather = TodayWeather.sampleData[0]
    static var previews: some View {
        CardView(todayWeather: weather)
            .background(.red)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
