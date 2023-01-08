//
//  ImageView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 8/1/2023.
//

//Source code: https://betterprogramming.pub/how-to-pick-an-image-from-camera-or-photo-library-in-swiftui-a596a0a2ece
//https://github.com/karthironald/SUImagePickerView

import SwiftUI

struct ImageView: View {
    
    @State private var image: Image? = Image("placeholder")
    @State private var isPresentedImagePicker = false
    @State private var isPresentedActionScheet = false
    @State private var isPresentedCamera = false
    
    var body: some View {
        image!
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 300)
            .onTapGesture {
                self.isPresentedActionScheet = true
            }
            .sheet(isPresented: $isPresentedImagePicker) {
                ImagePickerViewModel(sourceType: self.isPresentedCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$isPresentedImagePicker)
            }
            .actionSheet(isPresented: $isPresentedActionScheet) { () -> ActionSheet in
                ActionSheet(title: Text("Mode?"), message: Text("Please choose either take photo from camera or pick up from photo library"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                    self.isPresentedImagePicker = true
                    self.isPresentedCamera = true
                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                    self.isPresentedImagePicker = true
                    self.isPresentedCamera = false
                }), ActionSheet.Button.cancel()])
            }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
