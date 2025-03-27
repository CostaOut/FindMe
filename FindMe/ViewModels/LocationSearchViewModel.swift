//
//  LocationSearchViewModel.swift
//  FindMe
//
//  Created by Andrea Costantin on 24/03/25.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var query = "" {
        didSet {
            searchCompleter.queryFragment = query
        }
    }
    
    @Published var suggestions: [MKLocalSearchCompletion] = []
    @Published var selectedPlaceCoordinates: CLLocationCoordinate2D?

    private var searchCompleter = MKLocalSearchCompleter()
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.suggestions = completer.results
        }
    }

    func getCoordinates(for suggestion: MKLocalSearchCompletion, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = suggestion.title
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(coordinate)
            }
        }
    }
}
