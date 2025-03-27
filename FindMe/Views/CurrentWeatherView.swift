//
//  CurrentWeatherView.swift
//  FindMe
//
//  Created by Andrea Costantin on 05/03/25.
//

import SwiftUI

let currentWeatherTest: CurrentWeather = CurrentWeather(temp: 12.0, humidity: 2, wind_speed: 0.2, sunrise: 1741154175, sunset: 1741194988, weather: [WeatherCondition(description: "Ciao", icon: "1d")])

struct CurrentWeatherView: View {
    var locationName: String
    var weather: CurrentWeather
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Data e luogo
            VStack(alignment: .leading, spacing: 2) {
                Text(formattedTodayDate())
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(locationName)
                    .font(.title3)
            }
            
            
            HStack(alignment: .lastTextBaseline) {
                HStack (spacing: 14){
                    VStack(alignment: .leading, spacing: 8) {
                        WeatherInfoView(icon: "sunrise", value: formatUnixTimestamp(weather.sunrise), measureUnit: "")
                        WeatherInfoView(icon: "sunset", value: formatUnixTimestamp(weather.sunset), measureUnit: "")
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        WeatherInfoView(icon: "drop", value: weather.humidity, measureUnit: "%")
                        WeatherInfoView(icon: "wind", value: weather.wind_speed, measureUnit: "km/h")
                    }
                }
                .frame(alignment: .leading)
                
                Spacer()
                
                // Temperatura attuale con effetto di ombra
                Text("\(Int(weather.temp))°")
                    .font(.system(size: 96, weight: .medium))
                    .frame(minWidth: 100, alignment: .trailing)
            }
        }
        .frame(minHeight: 170)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
        )
        .padding(.horizontal)
    }
    
    func formatUnixTimestamp(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func formattedTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM HH:mm" // Formato desiderato
        formatter.locale = Locale(identifier: "en_US") // Inglese per "Today"
        return "Today, " + formatter.string(from: Date())
    }
}

#Preview {
    CurrentWeatherView(locationName: "Piazza della Repubblica", weather: currentWeatherTest)
}
