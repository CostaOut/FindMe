//
//  MapView.swift
//  FindMe
//
//  Created by Andrea Costantin on 04/03/25.
//

import SwiftUI
import MapKit
import CoreLocation

// MARK: - Mappa con posizione dell'utente
struct MapView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var position: MapCameraPosition = .automatic
    
    init() {
        // Imposta una posizione iniziale con zoom personalizzato
        let initialRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 45.4642, longitude: 9.1900), // Milano
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005) // Zoom personalizzato
        )
        _position = State(initialValue: .region(initialRegion))
    }
    
    @State private var camera: MapCamera = MapCamera(
        centerCoordinate: CLLocationCoordinate2D(latitude: 45.4642, longitude: 9.1900),
        distance: 500,
        heading: 0,
        pitch: 45
    )
    @State private var lastInteractionTime = Date()
    
    var body: some View {
        ZStack() {
        /*
             ** Vecchio Metodo
             Map(coordinateRegion: $region, showsUserLocation: true)
         */
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.white)
                Map(position: $position) {
                    if let userLocation = locationManager.userLocation {
                        Annotation("Tu", coordinate: userLocation.coordinate) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .foregroundColor(.blue)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 4)
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .onAppear {
                    centerMapOnUser()
                    startAutoRecentering()
                }
                .gesture(
                    DragGesture().onChanged { _ in
                        lastInteractionTime = Date() // Registra l'ultima interazione
                    }
                )
            }
            
            
            if let location = locationManager.userLocation?.coordinate {
                WeatherOverlayView(location: location, locationName: locationManager.locationName)
            }
        }
        .onAppear {
            locationManager.requestLocation()
            if let userLocation = locationManager.userLocation {
                updateCameraPosition(to: userLocation.coordinate)
            }
        }
        .onChange(of: locationManager.userLocation) { oldLocation, newLocation in
            if let coordinate = newLocation?.coordinate {
                updateCameraPosition(to: coordinate)
            }
        }
    }
    
    /// Imposta la mappa con zoom e inclinazione iniziali
    private func centerMapOnUser() {
        if let userLocation = locationManager.userLocation {
            position = .region(
                MKCoordinateRegion(
                    center: userLocation.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005) // Controlla lo zoom
                )
            )
        }
    }

    /// Avvia un timer che recentra la mappa dopo 10 secondi di inattività
    private func startAutoRecentering() {
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            let timeSinceLastInteraction = Date().timeIntervalSince(lastInteractionTime)
            if timeSinceLastInteraction > 10 { // Nessuna interazione per 10 secondi
                centerMapOnUser()
            }
        }
    }
    
    private func updateCameraPosition(to coordinate: CLLocationCoordinate2D) {
        camera = MapCamera(
            centerCoordinate: coordinate,
            distance: 500,
            heading: 0,
            pitch: 45
        )
    }
}

#Preview {
    MapView()
        .environmentObject(LocationManager())
}
