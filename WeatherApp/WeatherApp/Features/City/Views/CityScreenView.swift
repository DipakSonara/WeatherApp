//
//  CityScreenView.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 18/10/23.
//

import Foundation
import SwiftUI

struct CityScreenView: View {
    @StateObject var viewModel: CityScreenViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: self.viewModel.loadBackgroundImage ? [Color(#colorLiteral(red: 0.09411764706, green: 0.4196078431, blue: 0.8431372549, alpha: 1)), Color(#colorLiteral(red: 0.5441120482, green: 0.5205187814, blue: 0.9921568627, alpha: 1))] : [Color(#colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.262745098, alpha: 1)), Color(#colorLiteral(red: 0.3647058824, green: 0.5058823529, blue: 0.6549019608, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)

            ScrollView(showsIndicators: false) {
                VStack {
                    /// Weather icon, description, place and date.
                    HStack {
                        Image("\(self.viewModel.weatherIcon)")
                            .resizable()
                            .frame(width: 92, height: 92)
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                        VStack(alignment: .trailing, spacing: 5.0) {
                            Text(self.viewModel.weatherType)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                            Text(self.viewModel.todayWeatherObject.name)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                            Text(self.viewModel.date)
                                .font(.footnote)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                        }
                    }
                    .padding(.horizontal, 16)

                    /// Temperature reading.
                    Text(self.viewModel.temperature)
                        .font(.system(size: 72))
                        .bold()
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)

                    /// Sunrise and sunset.
                    HStack(spacing: 40) {
                        HStack {
                            Image(systemName: "sunrise")
                            Text("\(self.viewModel.sunrise.replacingOccurrences(of: "AM", with: "")) am")
                        }

                        HStack {
                            Image(systemName: "sunset")
                            Text("\(self.viewModel.sunset.replacingOccurrences(of: "PM", with: "")) pm")
                        }
                    }
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)

                    /// Grid view of other weather details.
                    VStack(spacing: 47) {
                        HStack(spacing: 5) {
                            DetailView(icon: "thermometer.sun", title: CityScreen.humidityTitle, data: "\(self.viewModel.todayWeatherObject.current)", unit: "%")
                            Spacer()
                            DetailView(icon: "tornado", title: CityScreen.windSpeedTitle, data: "\(self.viewModel.todayWeatherObject.windSpeed)", unit: "Km/hr")
                        }

                        HStack(spacing: 5) {
                            DetailView(icon: "arrow.down.circle", title: CityScreen.minTempTitle, data: "\(self.viewModel.todayWeatherObject.low)", unit: "°C")
                            Divider().frame(height: 50).background(Color.white)
                            DetailView(icon: "arrow.up.circle", title: CityScreen.maxTempTitle, data: "\(self.viewModel.todayWeatherObject.high)", unit: "°C")
                        }

                        HStack(spacing: 5) {
                            DetailView(icon: "heart", title: CityScreen.feelsLikeTitle, data: "\(self.viewModel.todayWeatherObject.feelsLike)", unit: "°C")
                            Divider().frame(height: 50).background(Color.white)
                            DetailView(icon: "rectangle.compress.vertical", title: CityScreen.pressureTitle, data: "\(self.viewModel.todayWeatherObject.pressure)", unit: "hPa")
                        }
                    }
                    .padding(.vertical, 30)
                    .background(Color.secondary.opacity(0.30))
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }

            }
            .padding(.top)
            .padding(.horizontal)
            .edgesIgnoringSafeArea(.horizontal)
        }
    }

}

struct CityScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CityScreenView(viewModel: CityScreenViewModel(todayWeatherObject: .sampleData[0]))
    }
}
