//
//  CommentFormView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 8/1/2023.
//

//Source code: https://betterprogramming.pub/create-a-form-in-swiftui-2-0-3a7f26303fd2



import SwiftUI
import Combine
import UIKit

struct PostCaptionView: View {

    @Environment(\.dismiss) var dismiss
    
    @State var caption: String = ""
    
    @State private var image: Image? = Image(systemName: "square.and.arrow.up.on.square.fill")
    
    @State var textPlaceHolder = "Write a caption here..."
    
    @State private var isShareSheetDisplay = false
    @State private var isPresentedImgPickerActionSheet = false
    @State private var isPresentedImagePicker = false
    @State private var isPresentedCamera = false
    @State var imageURLList = [String]()
    @State var shopID: String
    
    @State private var isPresentedPostActionSheet = false
    @State private var isShowingImgAlert = false
    @State private var isPostedAlert = false
    @State private var isUploadedImage = false
    
    
    @ObservedObject var viewModel = ImageCaptionAddDataViewModel()
    
    
    var body: some View {
        
        NavigationView {

            Form {
                HStack {
                    VStack {
                        image!
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .frame(width: 200, height: 150)
                            .opacity(image == Image(systemName: "square.and.arrow.up.on.square.fill") ? 0.6 : 1)
                            .onTapGesture {
                                self.isPresentedImgPickerActionSheet = true
                            }
                            .sheet(isPresented: $isPresentedImagePicker) {
                                //                            ImagePickerController(isPresented: self.$isPresentedImagePicker, imageURLList: self.$imageURLList, shopID: self.$shopID, image: self.$image)
                                
                                ImagePickerController(sourceType: self.isPresentedCamera ? .camera : .photoLibrary, isPresented: self.$isPresentedImagePicker, imageURLList: self.$imageURLList, shopID: self.$shopID, image: self.$image)
                                
                            }
                            .actionSheet(isPresented: $isPresentedImgPickerActionSheet) { () -> ActionSheet in
                                ActionSheet(title: Text("Mode?"), message: Text("Please choose either take photo from camera or pick up from photo library"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                    self.isPresentedImagePicker = true
                                    self.isPresentedCamera = true
                                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                    self.isPresentedImagePicker = true
                                    self.isPresentedCamera = false
                                }), ActionSheet.Button.cancel()])
                            }
                        
                        Text("Upload a photo here").font(.caption).foregroundColor(.secondary)
                    }

                    TextEditor(text: $caption)
                        .frame(width: 150, height: 400)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                        .opacity(caption.isEmpty || caption == textPlaceHolder ? 0.5 : 1)

                }

            }
                .navigationTitle("Post a Photo")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading:
                        Button(action: {
                            self.isPresentedPostActionSheet = true
                        }) {
                            Image(systemName: "xmark").foregroundColor(.red)
                        }
                        .actionSheet(isPresented: $isPresentedPostActionSheet) { () -> ActionSheet in
                            ActionSheet(title: Text("Are you sure discarding your post?"), message: Text("You have to choose a photo and write a caption again."), buttons: [ActionSheet.Button.default(Text("Discard"), action: {
                                dismiss()
                            }), ActionSheet.Button.cancel()])
                        }
                        .interactiveDismissDisabled(!isPresentedPostActionSheet)
                    
                    ,trailing:
                    Button(action: {
                        if image == Image(systemName: "square.and.arrow.up.on.square.fill"){
                            isShowingImgAlert = true
                            isUploadedImage = false
                        } else {
                            print("post button")
                            print(String(imageURLList[0]))
                            viewModel.postTapped(shopID: shopID, imageURL: String(imageURLList[0]), caption: caption)
                            print("posted already")
                            dismiss()
                        }
                    }) {
                        Text("Share")
                    }
                        .alert(isPresented: $isShowingImgAlert) {
                            Alert(title: Text("You didn't choose a photo"), message: Text("Please choose a photo from the photo icon first."), dismissButton: .default(Text("OK")))
                        }
                        .alert(isPresented: $isPostedAlert) {
                            Alert(title: Text("Your post has been shared"), message: Text("Please take a look!"), dismissButton: .default(Text("OK")))
                        }
                )
        }
            
        
    }
}

struct PostCaptionView_Previews: PreviewProvider {
    static var previews: some View {
        PostCaptionView(shopID: "1000")
    }
}
