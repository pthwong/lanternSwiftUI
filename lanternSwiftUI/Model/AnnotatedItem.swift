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
    var description: String
    var address: String
    var district: String
    var latitude: Double
    var longitude: Double

}


