//
//  LocationInfoViewFB.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 7/1/2023.
//

import SwiftUI

struct LocationInfoViewFB: View {
    var place: PlaceColFB
    
    @ObservedObject var viewModel = PlacesViewModelFB()
    
    @State private var isShareSheetDisplay = false
    
    let placeholder = UIImage(named: "placeholder.jpg")!
    
    var image: UIImage? {
        viewModel.data.flatMap(UIImage.init)
    }

//    let image = UIImage(data: data!)

    var body: some View {
        let url = URL(string: place.website)!
        let message = "\n\nHere are the information of Paper Lantern Shop:\nName: \(place.name) \nAddress: \(place.address) \nPhone: \(place.telephone) \nEmail: \(place.email)\n \nCheck it out!"
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    Image(uiImage: image ?? placeholder)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                    
                    Spacer()
                    
                    Text(place.name)
                        .font(.title)
                        .bold()
                        .padding()
                }

                // Button to share / bookmark / website

                HStack {
                    if #available(iOS 16.0, *) {
                        ShareLink(item: url, subject: Text("Check It Out!"), message:Text(message)) {
                            Image(systemName: "square.and.arrow.up")
                        }.font(.title2).padding()

                    } else {
                        // Fallback on earlier versions
                        Button(action: {
                            isShareSheetDisplay.toggle()
                            
                            let text = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                            
                            UIApplication.shared.windows.first?
                                .rootViewController?.present(text, animated: true,
                                                             completion: nil)
                            
                        }) {
                            Image(systemName: "square.and.arrow.up").font(.title2).padding()
                        }
                    }
                    
                    Button(action: {
                        Text("Button")
                    }) {
                        Image(systemName: "bookmark.fill")
                    }.font(.title2).padding()
                    
                }
                
                Divider()
                
                // Information
                
                HStack {
                    Image(systemName: "location.fill").font(.title3)
                    Text(place.address)
                }.font(.subheadline)
                    .padding()
                
                HStack {
                    Image(systemName: "phone.fill").font(.title3)
                    Text("\(place.telephone)")
                }.font(.subheadline)
                    .padding()
                
                
                HStack {
                    Image(systemName: "envelope.fill").font(.title3)
                    Text(place.email)
                }.font(.subheadline)
                    .padding()
                
                
                Divider()
                
                Text("About \(place.name)")
                    .font(.title2).bold().padding()
                
                
                Text(place.description).padding()
                
                
                
            }.padding()
                .navigationTitle(place.name)
                .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

struct LocationInfoViewFB_Previews: PreviewProvider {
    static var previews: some View {
        LocationInfoViewFB(place: PlaceColFB(id: "1000", name: "Paper Lanterns Places", address: "Flat 5, 10/F, Kam Shing Building, 12 Wang Hoi Road, Kowloon Bay", description: "Paper Lanterns Places", district: "Kowloon Bay", website: "https://web.whatsapp.com", telephone: "98674321", email: "abc@gmail.com", latitude: 22.322946, longitude: 114.21071, mainImgPath: "mainImg/1000.jpg"))
    }
}
