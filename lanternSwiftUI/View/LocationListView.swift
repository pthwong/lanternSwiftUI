//
//  LocationListView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 6/1/2023.
//

import SwiftUI
import CoreLocation

struct LocationListView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {

            List(lanternLocation) { location in
                
                let locationCoor = CLLocation(latitude: location.latitude, longitude: location.longitude)
                
                let distance = locationCoor.distance(from: CLLocation(latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude))
                
                let distanceKm = distance/1000

                NavigationLink {
                    LocationInfoView(locations: location)
                }
            label: {
                VStack(alignment: .leading) {
                    Text(location.name).font(.title2).bold()
                    Text(location.district).opacity(0.8)
                    
                    if distanceKm >= 10 {
                        Text("The location is not nearby your location").opacity(0.6).font(.caption)
                    } else {
                        Text("Distance: \(distanceKm, specifier: "%.1f") km").opacity(0.8)
                    }
                }
            }
                
            }
            
            
            
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
