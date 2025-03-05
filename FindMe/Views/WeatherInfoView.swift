//
//  CurrentWeatherElement.swift
//  FindMe
//
//  Created by Andrea Costantin on 05/03/25.
//

import SwiftUI

struct WeatherInfoView: View {
    var icon: String = "wind"
    var value: Any = 12.0
    var measureUnit: String = "%"
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: icon)
                .foregroundStyle(.primary)
                .padding(.trailing, 6)
                .frame(minWidth: 28)
            Text("\(value)")
                .font(.subheadline)
            Text(measureUnit)
                .font(.subheadline)
        }
    }
}

#Preview {
    WeatherInfoView()
}
