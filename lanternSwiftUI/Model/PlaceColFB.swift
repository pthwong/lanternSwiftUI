//
//  PlaceCol.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 7/1/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct PlaceColFB : Identifiable {
    var id: String
    let name : String
    var address: String
    var description: String
    var district: String
    var website: String
    var telephone: String
    var email: String
    var latitude: Double
    var longitude: Double
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case description
        case district
        case website
        case telephone
        case email
        case latitude
        case longtitude
        
        
    }

}
