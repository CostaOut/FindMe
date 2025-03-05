//
//  WeatherViewModel.swift
//  FindMe
//
//  Created by Andrea Costantin on 05/03/25.
//

import Foundation
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeater: CurrentWeather?
    @Published var dailyWeather: [DailyForecast]?
    
    private let weatherService = WeatherService()
    
    func loadWeather(for location: CLLocationCoordinate2D) {
        weatherService.fetchWeatherData(latitude: location.latitude, longitude: location.longitude) { result in
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.currentWeater = weatherData.current
                    self.dailyWeather = weatherData.daily
                }
            case .failure(let error):
                print("Error on fetching weather: \(error.localizedDescription)")
            }
        }
    }
}
