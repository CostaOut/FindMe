//
//  DailyForecastView.swift
//  FindMe
//
//  Created by Andrea Costantin on 27/03/25.
//

import SwiftUI



struct DailyForecastView: View {
    var dailyForecast: [DailyForecast] = []
    
    var body: some View {
        VStack {
            Text("Previsioni 7 Giorni")
                .frame(minHeight: 52)
                
            VStack(spacing: 16) {
                ForEach(dailyForecast.prefix(7)) { forecast in
                    DailyInfoForecastView(
                        day: formattedDate(forecast.dt),
                        icon: WeatherIcon.from(forecast.weather.first?.icon ?? "unknown").systemName,
                        maxTemperature: Int(forecast.temp.max),
                        minTemperature: Int(forecast.temp.min)
                    )
                }
            }
        }
    }
    
    private func formattedDate(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Giorno della settimana (es. "Monday")
        return formatter.string(from: date)
    }
}

#Preview {
    DailyForecastView(dailyForecast: fakeDailyForecast)
}
