//
//  LocationListViewFB.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 7/1/2023.
//

import SwiftUI
import CoreLocation

struct LocationListViewFB: View {
    @ObservedObject var viewModel = PlacesViewModelFB()
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {

        NavigationView {
            List(viewModel.places) { place in
                
                let placeCoor = CLLocation(latitude: place.latitude, longitude: place.longitude)
                
                let distance = placeCoor.distance(from: CLLocation(latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude))
                
                let distanceKm = distance/1000
     
                NavigationLink {
                    LocationInfoViewFB(place: place)
                }
                label: {
                    VStack(alignment: .leading) {
                        Text(place.name).font(.title2).bold()
                        Text(place.district).opacity(0.8)

                        if distanceKm >= 10 {
                            Text("The location is not nearby your location").opacity(0.6).font(.caption)
                        } else {
                            Text("Distance: \(distanceKm, specifier: "%.1f") km").opacity(0.8)
                        }
                    }
                }
                
            }.navigationTitle("Paper Lantern")
                .onAppear(){
                    self.viewModel.fetchData()
                }
        }
    }
}

struct LocationListViewFB_Previews: PreviewProvider {
    static var previews: some View {
        LocationListViewFB()
    }
}
