//
//  WeatherForecast.swift
//  FindMe
//
//  Created by Andrea Costantin on 04/03/25.
//

import Foundation

struct WeatherForecast: Decodable {
    var current: CurrentWeather
    var daily: [DailyForecast]
}

struct CurrentWeather : Decodable {
    var temp: Double
    var humidity: Int
    var wind_speed: Double
    var sunrise: Int
    var sunset: Int
    var weather: [WeatherCondition]
}

struct DailyForecast: Decodable, Identifiable{
    var id: Int {dt}
    var dt: Int
    var temp: DailyTemperature
    var weather: [WeatherCondition]
}

struct DailyTemperature: Decodable {
    var min: Double
    var max: Double
}

struct WeatherCondition: Decodable {
    var description: String
    var icon: String
}
