//
//  WeatherIcon.swift
//  FindMe
//
//  Created by Andrea Costantin on 05/03/25.
//

import Foundation

enum WeatherIcon: String {
    case clearSkyDay = "01d"
    case clearSkyNight = "01n"
    case fewCloudsDay = "02d"
    case fewCloudsNight = "02n"
    case scatteredClouds = "03d"
    case brokenClouds = "04d"
    case showerRain = "09d"
    case rainDay = "10d"
    case rainNight = "10n"
    case thunderstorm = "11d"
    case snow = "13d"
    case mist = "50d"

    /// Converte il codice icona di OpenWeather in un'icona SF Symbol
    var systemName: String {
        switch self {
        case .clearSkyDay: return "sun.max"
        case .clearSkyNight: return "moon.stars"
        case .fewCloudsDay: return "cloud.sun"
        case .fewCloudsNight: return "cloud.moon"
        case .scatteredClouds: return "cloud"
        case .brokenClouds: return "smoke"
        case .showerRain: return "cloud.heavyrain"
        case .rainDay: return "cloud.rain"
        case .rainNight: return "cloud.moon.rain"
        case .thunderstorm: return "cloud.bolt"
        case .snow: return "snowflake"
        case .mist: return "cloud.fog"
        }
    }

    /// Metodo statico per ottenere un'icona SF Symbol da una stringa
    static func from(_ code: String?) -> WeatherIcon {
        guard let code = code, let icon = WeatherIcon(rawValue: code) else {
            return .mist // Default in caso di errore
        }
        return icon
    }
}
