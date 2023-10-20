//
//  CardView.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 17/10/23.
//

import Foundation
import SwiftUI

struct CardView: View {
    let weather: TodayWeather

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("\(weather.name)")
                    .font(.headline)
                    .foregroundColor(Color.primary)
                Spacer()
                if let weatherDetail = weather.weatherDetail.first {
                    Text(weatherDetail.weatherType)
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                }
            }
            Spacer()
            VStack {
                Text("\(Int(weather.current))℃")
                    .font(.title)
                    .foregroundColor(Color.primary)
                Spacer()
                Text("H:\(Int(weather.high))℃  L:\(Int(weather.low))℃")
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
        CardView(weather: weather)
            .background(.red)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
