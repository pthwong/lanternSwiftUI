//
//  ImageCaption.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 10/1/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct ImageCaption: Identifiable, Codable {
    @DocumentID var id: String?
    var shopID: String
    var caption: String
    var imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case shopID
        case caption
        case imageURL
    }
    
}
