//
//  AnnotatedItem.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import MapKit
import Foundation

struct AnnoatedItem : Identifiable {
    let id = UUID()
    let name : String
    var description: String
    //var coordinates : CLLocationCoordinate2D
    
    var coordinate : Coordinate
    var locationCoordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}
