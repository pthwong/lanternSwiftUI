//
//  LocationListViewFB.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 7/1/2023.
//

import SwiftUI
import FirebaseStorage
import Combine
import CoreLocation
import UIKit


struct LocationListViewFB: View {
    @ObservedObject var viewModel = PlacesViewModelFB()
    
    @StateObject private var locationManager = LocationManager()
    
    let placeholder = UIImage(named: "placeholder.jpg")!
    
//    var image: UIImage?
//
//    ForEach(viewModel.data) {item in
//
//        image {
//            item.flatMap(UIImage.init)
//        }
//
//    }
//
    var image: UIImage? {
        viewModel.data.flatMap(UIImage.init)
    }
    
    var body: some View {

        NavigationView {
            List(viewModel.places) { place in
                
                let placeCoor = CLLocation(latitude: place.latitude, longitude: place.longitude)
                
                let distance = placeCoor.distance(from: CLLocation(latitude: locationManager.region.center.latitude, longitude: locationManager.region.center.longitude))
                
                let distanceKm = distance/1000
                
//                let image = UIImage(named: place.mainImgPath)

                NavigationLink {
                    LocationInfoViewFB(place: place)
                }
                label: {
                    HStack {
                        Image(uiImage: image ?? placeholder)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                        VStack(alignment: .leading) {
                            Text(place.name).font(.title2).bold()
                            Text(place.district).opacity(0.8)
                            
                            if distance >= 10000 {
                                Text("The location is not nearby your location").opacity(0.6).font(.caption)
                            } else if distance < 1000 {
                                Text("Distance: \(distance, specifier: "%.1f") m").opacity(0.8)
                            } else {
                                Text("Distance: \(distanceKm, specifier: "%.1f") km").opacity(0.8)
                            }
                        }
                    }
                    
                    
                    
                }
                
            }.navigationTitle("Paper Lantern")
                .onAppear(){
                    self.viewModel.fetchLanternShopInfo()
                }
        }
    }
}

struct LocationListViewFB_Previews: PreviewProvider {
    static var previews: some View {
        LocationListViewFB()
    }
}
