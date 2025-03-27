//
//  APIKeys.swift
//  FindMe
//
//  Created by Andrea Costantin on 05/03/25.
//

import Foundation

struct APIKeys {
    static let weatherAPIKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
            fatalError("API Key missing! Be sure to configure it in the Secrets.xcconfig file")
        }
        
        return key
    }()
    
    static let kitchenAPI: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String else {
            fatalError("API Key missing! Be sure to configure it in the Secrets.xcconfig file")
        }
        
        return key
    }()
}
