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
    @State var imageFileName:String = ""
    
    func makeCoordinator() -> ImagePickerController.Coordinator {
        return ImagePickerController.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var parent: ImagePickerController
        let storage = Storage.storage().reference()
        init(parent: ImagePickerController) {
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
            return returnString
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            parent.imageFileName = makeImageFileName()
//            NavigationLink(destination: PostCaptionView(image: image))
            //uploadImageToFireBase(image: image)
        }
        
        func uploadImageToFireBase(image: UIImage) {
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
                
                
                self.loadImageFromFirebase(imagePath: self.parent.imageFileName)
                print("Upload size is \(size)")
                print("Upload success")
                self.parent.isPresented.toggle()
            }
        }
        
        func loadImageFromFirebase(imagePath: String) {
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
