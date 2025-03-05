//
//  LocationService.swift
//  FindMe
//
//  Created by Andrea Costantin on 04/03/25.
//

import Foundation
import CoreLocation

// MARK: - Gestore della posizione dell'utente
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    @Published var locationName: String = "Uknown Location"
    
    private let fakeLocation = CLLocation(latitude: 45.4642, longitude: 9.1900) // Milano come posizione fake

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    /// Metodo chiamato quando la posizione viene aggiornata
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLocation = location // Aggioriamo la variabile relativa alla posizione dell'utente
                self.getPlaceName(from: location)
            }
        } else {
            useFakeLocation()
        }
    }
    
    /// Metodo chiamato in caso di errore nella localizzazione
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Errore nella localizzazione: \(error.localizedDescription)")
    }
    
    /// Recupera il nome del posto in cui si trova l'utente facendo una geocodfica inversa
    func getPlaceName(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    self.locationName = placemark.locality ?? placemark.name ?? "Uknown Location"
                }
            }
        }
    }
    
    func useFakeLocation() {
        DispatchQueue.main.async {
            self.userLocation = self.fakeLocation
        }
    }
}


/*
 
 NSObject
 è la classe base di tutti gli oggetti Objective-C, necessaria quando lavoriamo con API di UIKit o Foundation che richiedono un delegate.
 In questo caso specifico LocationManager eredita da NSObject perchè CLLocationManagerDelegate è un protocollo Objective-C

 
 ObservableObject
 è un protocollo SwiftUI che permette alla nostra classe di notificare le viste quando cambia uno stato.
 In questo caso usa @Published su userLocation, quindi ogni volta che cambia, SwiftUI aggiorna la UI
 
 CLLocationManagerDelegate
 Questo protocollo fornisce metodi per gestire eventi legati alla localizzazione, come:
 didUpdateLocations → Riceve nuove coordinate GPS quando disponibili.
 didFailWithError → Riceve un errore se la localizzazione fallisce.
 
 */
