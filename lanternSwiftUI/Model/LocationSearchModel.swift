//
//  LocalSearchService.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 5/1/2023.
//

import Foundation
import MapKit
import Combine

class LocationSearchModel: ObservableObject {
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    let locationManager = LocationManager()
    var cancellables = Set<AnyCancellable>()
    @Published var landmarks: [AnnotatedItem] = []
    @Published var landmark: AnnotatedItem?
    
    init() {
        locationManager.$region.assign(to: \.region, on: self)
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        
        let request = MKLocalSearch.Request()

        request.region = locationManager.region
        
        
        
    }
}
