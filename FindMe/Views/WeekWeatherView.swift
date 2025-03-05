//
//  WeekWeatherView.swift
//  FindMe
//
//  Created by Andrea Costantin on 05/03/25.
//

import SwiftUI
let fakeDailyForecast: [DailyForecast] = [
    DailyForecast(
        dt: Int(Date().timeIntervalSince1970),
        temp: DailyTemperature(min: 10.0, max: 15.0),
        weather: [WeatherCondition(description: "Poche nuvole", icon: "02d")]
    ),
    DailyForecast(
        dt: Int(Date().addingTimeInterval(86400).timeIntervalSince1970),
        temp: DailyTemperature(min: 11.0, max: 16.0),
        weather: [WeatherCondition(description: "Soleggiato", icon: "01d")]
    ),
    DailyForecast(
        dt: Int(Date().addingTimeInterval(86400 * 2).timeIntervalSince1970),
        temp: DailyTemperature(min: 12.0, max: 17.0),
        weather: [WeatherCondition(description: "Coperto", icon: "04d")]
    ),
    DailyForecast(
        dt: Int(Date().addingTimeInterval(86400 * 3).timeIntervalSince1970),
        temp: DailyTemperature(min: 13.0, max: 18.0),
        weather: [WeatherCondition(description: "Pioggia", icon: "10d")]
    ),
    DailyForecast(
        dt: Int(Date().addingTimeInterval(86400 * 4).timeIntervalSince1970),
        temp: DailyTemperature(min: 14.0, max: 19.0),
        weather: [WeatherCondition(description: "Temporale", icon: "11d")]
    )
]


struct WeekWeatherView: View {
    var forecast: [DailyForecast]
    var body: some View {
        HStack {
            ForEach(forecast.prefix(5)) { day in
                DayWeatherInfo(icon: WeatherIcon.from(day.weather.first?.icon ?? "unknown"), day: formattedDate(day.dt))
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(minHeight: 40)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
        )
        .padding(.horizontal)
    }
    
    private func formattedDate(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Giorno della settimana (es. "Gio")
        return formatter.string(from: date)
    }
}

#Preview {
    WeekWeatherView(forecast: fakeDailyForecast)
}
