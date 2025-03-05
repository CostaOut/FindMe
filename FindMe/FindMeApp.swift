//
//  FindMeApp.swift
//  FindMe
//
//  Created by Andrea Costantin on 04/03/25.
//

import SwiftUI

@main
struct FindMeApp: App {
    @StateObject private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
        }
    }
}
