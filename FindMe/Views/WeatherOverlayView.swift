//
//  WeatherOverlayView.swift
//  FindMe
//
//  Created by Andrea Costantin on 04/03/25.
//

import SwiftUI
import CoreLocation

struct WeatherOverlayView: View {
    var location: CLLocationCoordinate2D?
    var locationName: String?
    
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 8) {
            if let currentWeather = weatherViewModel.currentWeater {
                if let currentLocationName = locationName {
                    CurrentWeatherView(locationName: currentLocationName, weather: currentWeather)
                }
            } else {
                CurrentWeatherView(locationName: "Piazza della Repubblica", weather: currentWeatherTest)
            }
            if let dailyWeather = weatherViewModel.dailyWeather {
                WeekWeatherView(forecast: dailyWeather)
            } else {
                WeekWeatherView(forecast: fakeDailyForecast)
            }
            Spacer()
        }
        .padding(.top)
        .onAppear {
            if let location = location {
                weatherViewModel.loadWeather(for: location)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let currentWeater = weatherViewModel.currentWeater {
                    print(currentWeater)
                }
            }
        }
    }
}

#Preview {
    WeatherOverlayView()
}
