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
            VStack {
                Text("\(weather.name)")
                    .font(.title)
                Spacer()
                Text("\(weather.type)")
                    .font(.caption)
            }
            Spacer()
            VStack {
                Text("\(Int(weather.current))℃")
                    .font(.title)
                Spacer()
                Text("H:\(Int(weather.high))℃  L:\(Int(weather.low))℃")
                    .font(.headline)
            }
        }
        .padding()
        .foregroundColor(.yellow)
        .frame(height: 100.0)
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
