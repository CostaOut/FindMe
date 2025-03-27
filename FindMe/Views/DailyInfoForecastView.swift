//
//  DailyInfoForecastView.swift
//  FindMe
//
//  Created by Andrea Costantin on 27/03/25.
//

import SwiftUI

struct DailyInfoForecastView: View {
    var day: String
    var icon: String
    
    var maxTemperature: Int
    var minTemperature: Int
    
    var body: some View {
        ZStack {
            Image(systemName: icon)
                .frame(maxWidth: .infinity)
            HStack {
                Text(day)
                Spacer()
                Text("\(minTemperature)°/\(maxTemperature)°")
            }
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    DailyInfoForecastView(day: "Wednesday", icon: "cloud", maxTemperature: 24, minTemperature: 12)
}
