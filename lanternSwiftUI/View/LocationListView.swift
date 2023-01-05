//
//  LocationListView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationListView: View {

    @State var locationManager = LocationManager()
    
    
    var body: some View {
        NavigationView {
            List(lanternLocation) { location in
                
                let locationCoor = CLLocation(latitude: location.latitude, longitude: location.longitude)
                
                let distance = locationCoor.distance(from: CLLocation(latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude))
                
                
                NavigationLink(destination: LocationInfoView(locations: location)) {
                    VStack(alignment: .leading) {
                        Text(location.name).font(.title3).bold()
                        Text(location.address).opacity(0.6)
                        Text("Distance: \(distance/1000, specifier: "%.1f") km")
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
