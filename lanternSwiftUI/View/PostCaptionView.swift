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
    
    var image: UIImage
    
//    let placeholder2 = UIImage(named: "placeholder2.jpg")!
    
    @State var textPlaceHolder = "Write a caption here..."
    
    
    var body: some View {
        
        NavigationView {

            Form {
                HStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                    
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
                            print("cancel button")
                        }) {
                            Text("Cancel")
                        }
                    
                    ,trailing:
                    Button(action: {
                        print("post button")
                    }) {
                        Text("Post")
                    }
                )
            


        }
            
        
    }
}

struct PostCaptionView_Previews: PreviewProvider {
    static var previews: some View {
        PostCaptionView(image: UIImage(named: "placeholder2.jpg")!)
    }
}
