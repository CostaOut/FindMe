//
//  WeatherService.swift
//  FindMe
//
//  Created by Andrea Costantin on 05/03/25.
//

import Foundation
import Alamofire
import CoreLocation

class WeatherService {
    private let apiKey = APIKeys.weatherAPIKey
    private let baseURL = "https://api.openweathermap.org/data/3.0/onecall"
    
    /// Metodo per ottenere il meteo attuale
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherForecast, Error>) -> Void) {
        let parameters: [String: Any] = [
            "lat": latitude,
            "lon": longitude,
            "exclude": "minutely,hourly",
            "units": "metric",
            "appid": apiKey,
            "lang": "it"
        ]
        
        // Chiamata API con Alamofire
        AF.request(baseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: WeatherForecast.self) { response in
                switch response.result {
                case .success(let weatherData):
                    completion(.success(weatherData))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
    }
    
}
