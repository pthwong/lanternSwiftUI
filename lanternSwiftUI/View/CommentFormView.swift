//
//  CommentFormView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 8/1/2023.
//

//Source code: https://betterprogramming.pub/create-a-form-in-swiftui-2-0-3a7f26303fd2



import SwiftUI

struct CommentFormView: View {
    
    @State var commentTitle: String = ""
    @State var comment: String = ""
    
    var body: some View {
        NavigationView {
            
            Form {
                HStack {
                    Text("Title")
                    Spacer(minLength: 20)
                    TextField("Title", text: $commentTitle)
                }
                HStack {
                    Text("Comment")
                    Spacer(minLength: 20)
                    TextField("Comment", text: $comment)
                }
            }
                .navigationTitle("Write a Comment")
                .navigationBarItems(trailing:                    Button(action: {
                    print("save button")
                }) {
                    Text("Save")
                }
                )
            
            
        }
        
    }
}

struct CommentFormView_Previews: PreviewProvider {
    static var previews: some View {
        CommentFormView()
    }
}
