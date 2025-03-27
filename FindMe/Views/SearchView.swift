//
//  SearchView.swift
//  FindMe
//
//  Created by Andrea Costantin on 20/03/25.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    var location: PlaceLocation?
    @StateObject private var weatherViewModel = WeatherViewModel()
    var currentWeather: CurrentWeather?
    
    var body: some View {
        VStack {
            HStack {
                WeatherInfoIconView(icon: "drop", value: weatherViewModel.currentWeater?.humidity ?? 0, measureUnit: "%")
                Spacer()
                WeatherInfoIconView(icon: "wind", value: weatherViewModel.currentWeater?.wind_speed ?? 0, measureUnit: "km/h")
                Spacer()
                WeatherInfoIconView(icon: "Min:", value: 3, measureUnit: "°", hasIcon: false)
                Spacer()
                WeatherInfoIconView(icon: "Max:", value: 13, measureUnit: "°", hasIcon: false)
            }
            
            VStack {
                Text("\(Int(weatherViewModel.currentWeater?.temp ?? 0))°")
                    .font(.system(size: 96))
                Text(weatherViewModel.currentWeater?.weather[0].description ?? "")
                    .font(.title3)
            }
            .padding(.vertical, 32)
            
            HStack {
                WeatherInfoView(icon: "sunrise", value: formatUnixTimestamp(weatherViewModel.currentWeater?.sunrise ?? 0), measureUnit: "")
                Spacer()
                HStack {
                    Text("---")
                    Text("11h 18min")
                    Text("---")
                }
                Spacer()
                
                
                WeatherInfoView(icon: "sunset", value: formatUnixTimestamp(weatherViewModel.currentWeater?.sunset ?? 0), measureUnit: "")
                
            }
            
            Spacer()
        }
        .padding(.top, 32)
        .padding(.horizontal, 24)
        .onAppear {
            guard let location = location else {
                weatherViewModel.loadWeather(for: CLLocationCoordinate2D(latitude: 45.4642, longitude: 9.1900))
                return
            }
            weatherViewModel.loadWeather(for: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
    }
    
    func formatUnixTimestamp(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    SearchView()
}
