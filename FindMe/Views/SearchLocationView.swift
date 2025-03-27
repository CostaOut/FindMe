//
//  SearchLocationView.swift
//  FindMe
//
//  Created by Andrea Costantin on 24/03/25.
//

import SwiftUI

struct PlaceLocation: Hashable {
    let latitude: Double
    let longitude: Double
}

struct SearchLocationView: View {
    @StateObject private var locationSearchViewModel = LocationSearchViewModel()
    
    @State private var path: [PlaceLocation] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextField("Cerca un luogo...", text: $locationSearchViewModel.query)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                List(locationSearchViewModel.suggestions, id: \.self) { suggestion in
                    VStack(alignment: .leading) {
                        Text(suggestion.title)
                            .font(.headline)
                        if !suggestion.subtitle.isEmpty {
                            Text(suggestion.subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                    .onTapGesture {
                        locationSearchViewModel.getCoordinates(for: suggestion) { coordinate in
                            if let coordinate = coordinate {
                                let place = PlaceLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                path.append(place)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: PlaceLocation.self) { location in
                SearchView(location: location)
            }
        }
    }
}

#Preview {
    SearchLocationView()
}
