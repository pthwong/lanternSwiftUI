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

///Source code to implement:
// https://github.com/karthironald/SUImagePickerView
// https://github.com/loydkim/Firebase_Storage_Image_Thread

struct ImagePickerController: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var isPresented: Bool
    @Binding var imageURLList:[String]
//    @Binding var shopID:[String]
    
    @State var imageFileName:String = ""
    @Binding var image: Image?
    
    
    
    func makeCoordinator() -> ImagePickerController.Coordinator {
        return ImagePickerController.Coordinator(image: $image, parent: self, isPresented: $isPresented)
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        @Binding var image: Image?
        @Binding var isPresented: Bool
        
        var parent: ImagePickerController
        let storage = Storage.storage().reference()
        init(image: Binding<Image?>, parent: ImagePickerController, isPresented: Binding<Bool>) {
            self._image = image
            self._isPresented = isPresented
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented.toggle()
        }
        
        func makeImageFileName() -> String {
            var returnString = ""
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
            returnString = "images/image_"+formatter.string(from: date)+".jpg"
//            returnString = "images/\(shopID)/image_\(formatter.string(from: date)).jpg"
            return returnString
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            let image = info[.originalImage] as! UIImage
            
            if let image = info[.originalImage] as? UIImage {
                self.image = Image(uiImage: image)
            }
            self.isPresented = false
            
            
            parent.imageFileName = makeImageFileName()
//            PostCaptionView(image: image)
            //uploadImageToFB(image: image)
        }
        
        func uploadImageToFB(image: UIImage) {
            // Create the file metadata
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            // Upload the file to the path FILE_NAME
            storage.child(parent.imageFileName).putData(image.jpegData(compressionQuality: 0.4)!, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                  // Uh-oh, an error occurred!
                  print((error?.localizedDescription)!)
                  return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                
                
                self.loadImageFromFB(imagePath: self.parent.imageFileName)
                print("Upload size is \(size)")
                print("Upload success")
                self.parent.isPresented.toggle()
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
