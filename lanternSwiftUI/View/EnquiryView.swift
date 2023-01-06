//
//  EnquiryView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import SwiftUI
import CoreLocation
import MapKit


struct EnquiryView: View {
//    @State private var isSheetPresented = false
    
    @State var locationManager = LocationManager()
    
    var body: some View {
        
        VStack {
            Text("Lat: \(locationManager.region.center.latitude)\n Lon: \(locationManager.region.center.longitude)")
//            Button("Show Places' name") {
//                isSheetPresented.toggle()
//            }

            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: lanternLocation) { locations in
                
//                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                
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
                        
                                        Image(systemName: "mappin.circle.fill")
                                          .font(.title)
                                          .foregroundColor(.red)
                                        
                                        Image(systemName: "arrowtriangle.down.fill")
                                          .font(.caption)
                                          .foregroundColor(.red)
                                          .offset(x: 0, y: -5)
                                      }
                                    
//                                      Text(location.name)
//                                        .font(.caption2)
//                                        .bold()
//                                      Image(systemName: "star.fill")
//                                        .font(.title2)
//                                        .foregroundColor(.red)
//                                        .shadow(radius: 1)
//                                    }
                                }
                
            }
            
//                .sheet(isPresented: $isSheetPresented) {
//                    if #available(iOS 16.0, *) {
//                        LocationListView().presentationDetents([.medium, .large])
//                    }
//                    else {
//                        LocationListView()
//                    }
//                }
        
        }
//        ScrollView {
//            MapView()
//                .ignoresSafeArea(edges: .top)
//                .frame(height: 500)
//
//                .sheet(isPresented: $isSheetPresented) {
//                    if #available(iOS 16.0, *) {
//                        LocationListView().presentationDetents([.medium, .large])
//                    }
//                }
//
//            VStack(alignment: .leading) {
//                List(lanternLocation) { location in
//                    VStack(alignment: .leading) {
//                        Text(location.name).font(.title3).bold()
//                        Text(location.address).font(.caption)
//                        Text(location.description).font(.caption)
//                    }
//                }
//
//
//                Text("Turtle Rock")
//                    .font(.title)
//
//                HStack {
//                    Text("Joshua Tree National Park")
//                    Spacer()
//                    Text("California")
//                }
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//
//                Divider()
//
//                Text("About Turtle Rock")
//                    .font(.title2)
//                Text("Descriptive text goes here.")
//            }
//            .padding()

//        }
        


        
    }
}

struct EnquiryView_Previews: PreviewProvider {
    static var previews: some View {
        EnquiryView()
    }
}
