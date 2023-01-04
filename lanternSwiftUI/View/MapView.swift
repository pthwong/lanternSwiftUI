//
//  MapView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import SwiftUI
import MapKit



struct MapView: View {
    
    @StateObject var locationModel = LocationModel()
    
    @State private var region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.37464, longitude: 114.14907), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @State private var pointOfInterest = []

    
    var body: some View {
        
        if locationModel.authorizationStatus == .authorizedWhenInUse || locationModel.authorizationStatus == .authorizedAlways {
        
        Map(coordinateRegion: $region, annotationItems: lanternLocation) {
            item in
//            MapMarker(coordinate: item.locationCoordinate)
            MapAnnotation(coordinate: item.locationCoordinate) {
                Text(item.name)
                    .padding()
                    .background(in: Capsule())
                    .shadow(radius: 10)
                }
        }
        } else {
            VStack{
                Text("You have to give permission of your location before viewing the map.").padding(10)
                Button("Request Permission", action: {
                    locationModel.requestPermission()
                })
            }
        }

        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
       
    }
}
