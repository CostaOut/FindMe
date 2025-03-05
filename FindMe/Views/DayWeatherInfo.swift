//
//  DayWeatherInfo.swift
//  FindMe
//
//  Created by Andrea Costantin on 05/03/25.
//

import SwiftUI

struct DayWeatherInfo: View {
    var icon: WeatherIcon
    var day: String
    
    var body: some View {
        VStack {
            Image(systemName: icon.systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            Text(day)
                .font(.headline)
        }
    }
}

#Preview {
    DayWeatherInfo(icon: .clearSkyDay, day: "Lun")
}
