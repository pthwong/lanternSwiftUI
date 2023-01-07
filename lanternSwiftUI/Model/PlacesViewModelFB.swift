//
//  PlacesDataQueryModel.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 7/1/2023.
//

import Foundation
//import Combine
import FirebaseFirestore

class PlacesViewModelFB: ObservableObject {
    @Published var places = [PlaceColFB]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("lanternPlaces").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.places = documents.map { queryDocumentSnapshot -> PlaceColFB in
                let data = queryDocumentSnapshot.data()
                //Data of columns (let)
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let district = data["district"] as? String ?? ""
                let website = data["website"] as? String ?? ""
                let telephone = data["telephone"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let latitude = data["latitude"] as? Double ?? 0
                let longitude = data["longitude"] as? Double ?? 0
                
                return PlaceColFB(id: id, name: name, address: address, description: description, district: district, website: website, telephone: telephone, email: email, latitude: latitude, longitude: longitude)
            }
            
            
        }
        print(places)
    }
}
