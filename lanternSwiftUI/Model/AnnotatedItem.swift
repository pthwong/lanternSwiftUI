//
//  AnnotatedItem.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import MapKit
import Foundation

struct AnnotatedItem : Decodable, Identifiable {
    var id: Int
    let name : String
    var address: String
    var description: String
    var district: String
    var website: String
    var telephone: Int
    var email: String
    var latitude: Double
    var longitude: Double

}


