//
//  MapViewFB.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 7/1/2023.
//

import SwiftUI
import MapKit

struct MapViewFB: View {
    
    @ObservedObject var viewModel = PlacesViewModelFB()
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: viewModel.places) { place in
            
            MapAnnotation(coordinate:
                            CLLocationCoordinate2D(
                                latitude: place.latitude,
                                longitude: place.longitude
                            )) {
                                VStack {
                                    Text(place.name)
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
            
        }.onAppear(){
            self.viewModel.fetchData()
        }
    }
}

struct MapViewFB_Previews: PreviewProvider {
    static var previews: some View {
        MapViewFB()
    }
}
