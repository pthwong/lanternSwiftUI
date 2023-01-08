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

    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.361925, longitude: 114.151315), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: viewModel.places) { place in
            
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
            self.viewModel.fetchLanternShopInfo()
        }
    }
}

struct MapViewFB_Previews: PreviewProvider {
    static var previews: some View {
        MapViewFB()
    }
}
