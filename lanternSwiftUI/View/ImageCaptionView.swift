//
//  ImageCaptionView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 10/1/2023.
//

import SwiftUI

struct ImageCaptionView: View {
    
    var caption: ImageCaption
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: caption.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.purple.opacity(0)
                }
                .frame(width: 300, height: 200)
                .padding()
                
                Text(caption.caption).padding()
                Divider()
            }
        }
    }
}

struct ImageCaptionView_Previews: PreviewProvider {
    static var previews: some View {
        let caption = ImageCaption(shopID: "1001", caption: "Hello World", imageURL: "https://firebasestorage.googleapis.com:443/v0/b/lantern-app-31b4d.appspot.com/o/images%2F1001%2Fimage_2023_01_10_10_31_47.jpg?alt=media&token=d57416c9-163e-48ae-979c-8808b97094ba")
        ImageCaptionView(caption: caption)
    }
}
