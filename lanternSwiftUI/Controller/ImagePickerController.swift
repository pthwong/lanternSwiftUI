//
//  ImagePickerController.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 8/1/2023.
//

import Foundation

import SwiftUI
import FirebaseStorage
import Combine
import UIKit

///Source code helps me implementing app:
// https://github.com/karthironald/SUImagePickerView
// https://github.com/loydkim/Firebase_Storage_Image_Thread

struct ImagePickerController: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var isPresented: Bool
    @Binding var imageURLList:[String]
    @Binding var shopID: String

    
    @State var imageFileName:String = ""
    @Binding var image: Image?

    
    func makeCoordinator() -> ImagePickerController.Coordinator {
        return ImagePickerController.Coordinator(image: $image, parent: self, isPresented: $isPresented, shopID: $shopID)
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        @Binding var image: Image?
        @Binding var isPresented: Bool
        @Binding var shopID: String
        
        var parent: ImagePickerController
        let storage = Storage.storage().reference()
        init(image: Binding<Image?>, parent: ImagePickerController, isPresented: Binding<Bool>, shopID: Binding<String>) {
            self._image = image
            self._isPresented = isPresented
            self.parent = parent
            self._shopID = shopID
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented.toggle()
        }

        func makeImageFileName() -> String {
            var returnString = ""
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
            returnString = "images/\(shopID)/image_\(formatter.string(from: date)).jpg"
            return returnString
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            if let image = info[.originalImage] as? UIImage {
                self.image = Image(uiImage: image)
            }
            self.isPresented = false
            parent.imageFileName = makeImageFileName()
            uploadImageToFB(image: image)
        }
        
        func uploadImageToFB(image: UIImage) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            storage.child(parent.imageFileName).putData(image.jpegData(compressionQuality: 0.4)!, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                  print((error?.localizedDescription)!)
                  return
                }
                let size = metadata.size


                self.loadImageFromFB(imagePath: self.parent.imageFileName)
                print("Upload size is \(size)")
                print("Upload success")
            }
        }

        func loadImageFromFB(imagePath: String) {
            let storage = Storage.storage().reference(withPath: imagePath)
            storage.downloadURL { (url, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                print("Download success")
                let urlString = "\(url!)"
                self.parent.imageURLList.append(urlString)
                print("Download URL: \(urlString)")
            }
        }
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerController>) -> UIImagePickerController {
        let pickController = UIImagePickerController()
        pickController.sourceType = sourceType
        pickController.delegate = context.coordinator
        return pickController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerController>) {
    }
    
    
}
