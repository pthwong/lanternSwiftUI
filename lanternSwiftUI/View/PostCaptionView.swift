//
//  CommentFormView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 8/1/2023.
//

//Source code: https://betterprogramming.pub/create-a-form-in-swiftui-2-0-3a7f26303fd2



import SwiftUI

struct PostCaptionView: View {

    @State var caption: String = ""
    
    @State private var image: Image? = Image(systemName: "photo.fill")
    
//    let placeholder2 = UIImage(named: "placeholder2.jpg")!
    
    @State var textPlaceHolder = "Write a caption here..."
    
    @State private var isShareSheetDisplay = false
    @State private var isPresentedImgPickerActionScheet = false
    @State private var isPresentedImagePicker = false
    @State private var isPresentedCamera = false
    @State var imageURLList = [String]()
    
    @State private var isPresentedPostActionSheet = false
    @State private var isShowingImgAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationView {

            Form {
                HStack {
                    image!
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .opacity(image == Image(systemName: "photo.fill") ? 0.6 : 1)
                        .onTapGesture {
                            self.isPresentedImgPickerActionScheet = true
                        }
                        .sheet(isPresented: $isPresentedImagePicker) {
                            ImagePickerController(sourceType: self.isPresentedCamera ? .camera : .photoLibrary, isPresented: self.$isPresentedImagePicker, imageURLList: $imageURLList, image: self.$image)
                        }
                        .actionSheet(isPresented: $isPresentedImgPickerActionScheet) { () -> ActionSheet in
                            ActionSheet(title: Text("Mode?"), message: Text("Please choose either take photo from camera or pick up from photo library"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                self.isPresentedImagePicker = true
                                self.isPresentedCamera = true
                            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                self.isPresentedImagePicker = true
                                self.isPresentedCamera = false
                            }), ActionSheet.Button.cancel()])
                        }
                    
                    TextEditor(text: caption.isEmpty ? $textPlaceHolder : $caption)
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
                            ActionSheet(title: Text("Confirm to discard your post?"), message: Text("You have to choose a photo and write a caption again."), buttons: [ActionSheet.Button.default(Text("Discard"), action: {
                                dismiss()
                            }), ActionSheet.Button.cancel()])
                        }
                        .interactiveDismissDisabled(!isPresentedPostActionSheet)
                    
                    ,trailing:
                    Button(action: {
                        if image == Image(systemName: "photo.fill"){
                            isShowingImgAlert = true
                        } else {
                            print("post button")
                        }
                    }) {
                        Text("Share")
                    }
                        .alert(isPresented: $isShowingImgAlert) {
                            Alert(title: Text("You didn't choose a photo"), message: Text("Please choose a photo from the photo icon first."), dismissButton: .default(Text("OK")))
                        }
                )
            


        }
            
        
    }
}

struct PostCaptionView_Previews: PreviewProvider {
    static var previews: some View {
//        PostCaptionView(image: UIImage(named: "placeholder2.jpg")!)
        PostCaptionView()
    }
}
