//
//  WeatherInfoIconView.swift
//  FindMe
//
//  Created by Andrea Costantin on 20/03/25.
//

import SwiftUI

struct WeatherInfoIconView: View {
    var icon: String
    var value: Any = 12.0
    var measureUnit: String?
    
    var hasIcon: Bool = true
    
    var body: some View {
        HStack {
            if (hasIcon) {
                Image(systemName: icon)
            } else {
                Text(icon)
            }
            
            HStack(spacing: 1) {
                Text("\(value)")
                if (measureUnit != nil) {
                    Text(measureUnit!)
                }
            }
            
        }
    }
}

#Preview {
    WeatherInfoIconView(icon: "magnifyingglass", value: 0)
}

#Preview {
    WeatherInfoIconView(icon: "Max:", value: 12, measureUnit: "°", hasIcon: false)
}
