//
//  MapView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 7/1/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: lanternLocation) { locations in
            
            MapAnnotation(coordinate:
                            CLLocationCoordinate2D(
                                latitude: locations.latitude,
                                longitude: locations.longitude
                            )) {
                                VStack {
                                    Text(locations.name)
                                      .font(.callout)
                                      .padding(5)
                                      .background(Color(.white))
                                      .cornerRadius(10)
                                }
                                VStack {
                    
                                    Image(systemName: "mappin.circle.fill")
                                      .font(.title)
                                      .foregroundColor(.red)
                                    
                                    Image(systemName: "arrowtriangle.down.fill")
                                      .font(.caption)
                                      .foregroundColor(.red)
                                      .offset(x: 0, y: -5)
                                }
                                
                            }
            
        }
        
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
