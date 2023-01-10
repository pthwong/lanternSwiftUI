//
//  ImageCaptionViewModel.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 10/1/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore

///Source code helps me implementing app:
//https://github.com/peterfriese/BookSpine

class ImageCaptionAddDataViewModel: ObservableObject {
    
    @Published var captionModel: ImageCaption
    @Published var modified = false
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    init(captionModel: ImageCaption = ImageCaption(id: "", shopID: "", caption: "", imageURL: "")) {
        self.captionModel = captionModel
        
        self.$captionModel
            .dropFirst()
            .sink { [weak self] caption in
              self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    private func addCaption(_ caption: ImageCaption) {
        do {
            let _ = try db.collection("imageCap").addDocument(from: caption)
        }
        catch let error {
          print("Error:\n \(error)")
        }
    }
    
    func postTapped(shopID: String, imageURL: String, caption: String) {
        self.captionModel.shopID = shopID
        self.captionModel.imageURL = imageURL
        self.captionModel.caption = caption
        self.addCaption(captionModel)
    }
    
    
}
