//
//  LocationListViewFB.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 7/1/2023.
//

import SwiftUI
import CoreLocation


struct LocationListView: View {
    @ObservedObject var viewModel = PlacesViewModel()
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        
        NavigationView {
            
            List(viewModel.places) { place in
                
                let placeCoor = CLLocation(latitude: place.latitude, longitude: place.longitude)
                
                let distance = placeCoor.distance(from: CLLocation(latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude))
                
                let distanceKm = distance/1000
                
                NavigationLink {
                    LocationInfoView(place: place)
                }
            label: {
                HStack {
                    AsyncImage(url: URL(string: place.mainImgURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.red.opacity(0)
                    }
                    .frame(width: 125, height: 125)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    
                    VStack(alignment: .leading) {
                        Text(place.name).font(.title2).bold()
                        Text(place.district).opacity(0.8)
                        
                        if distance >= 10000 {
                            Text("The shop is not nearby your location").opacity(0.6).font(.caption)
                        } else if distance < 200 {
                            Text("Distance: \(distanceKm, specifier: "%.1f") km").opacity(0.8).foregroundColor(.red)
                        } else {
                            Text("Distance: \(distanceKm, specifier: "%.1f") km").opacity(0.8)
                        }
                    }
                }
            }
                
            }.navigationTitle("Paper Lantern Shop")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(){
                    self.viewModel.fetchLanternShopInfo()
                    print("Data are appeared.")
                }
                .onDisappear(){
                    print("Data are disappeared.")
                }
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
