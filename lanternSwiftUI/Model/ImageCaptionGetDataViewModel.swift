//
//  ImageCaptionGetDataViewModel.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 10/1/2023.
//

import Foundation
import Combine
import FirebaseFirestore

class ImageCaptionGetDataViewModel: ObservableObject {
    
    @Published var caption = [ImageCaption]()
    
    private var db = Firestore.firestore()
    
    let didChange = PassthroughSubject<Data?, Never>()
    var data: Data? = nil {
        didSet { didChange.send(data) }
    }
    
    func fetchCaptions(shopID: String) {
        db.collection("imageCap").whereField("shopID", isEqualTo: shopID).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.caption = documents.map { queryDocumentSnapshot -> ImageCaption in
                let data = queryDocumentSnapshot.data()
                //Data of columns (let)
                let id = data["id"] as? String ?? ""
                let shopID = data["shopID"] as? String ?? ""
                let caption = data["caption"] as? String ?? ""
                let imageURL = data["imageURL"] as? String ?? ""

                print(data)
                print(id)
                print(caption)
                print(shopID)

                return ImageCaption(id: id, shopID: shopID, caption: caption, imageURL: imageURL)
            }
        }
    }
}
