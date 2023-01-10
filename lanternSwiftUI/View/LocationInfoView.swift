//
//  LocationInfoViewFB.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 7/1/2023.
//

import SwiftUI

struct LocationInfoView: View {
    var place: PlaceCol
    
    @StateObject var captionViewModel = ImageCaptionGetDataViewModel()
    
    @State private var isShareSheetDisplay = false
    @State private var isShownPostView = false
    
    @State var imageURLList = [String]()
    //    @State var shopID: String
    
    private func captionRowView(caption: ImageCaption) -> some View {
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
    
    var body: some View {
        let url = URL(string: place.website)!
        let phone = URL(string: "tel:852\(place.telephone)")!
        let email = URL(string: "mailto:\(place.email)")!
        
        let message = "\n\nHere are the information of Paper Lantern Shop:\nName: \(place.name) \nAddress: \(place.address) \nPhone: \(place.telephone) \nEmail: \(place.email)\n \nCheck it out!"
        
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    HStack {
                        AsyncImage(url: URL(string: place.mainImgURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.red.opacity(0)
                        }
                        .frame(width: 110, height: 110)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .padding()
                        
                        Text(place.name)
                            .font(.title)
                            .bold()
                            .padding()
                    }
                }
                
                Group {
                    // Information
                    
                    HStack {
                        Image(systemName: "location.fill").font(.title3)
                        Text(place.address)
                    }.font(.subheadline)
                        .padding()
                    
                    HStack {
                        Link(destination: phone) {
                            Image(systemName: "phone.fill").font(.title3)
                            Text("\(place.telephone)")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.black)
                    }.font(.subheadline)
                        .padding()
                    
                    HStack {
                        Link(destination: email) {
                            Image(systemName: "envelope.fill").font(.title3)
                            Text(place.email)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }.font(.subheadline)
                        .foregroundColor(.black)
                        .padding()
                }
                
                Divider()
                
                Group {
                    Text("About \(place.name)")
                        .font(.title2).bold().padding()
                    Text(place.description).padding()
                }
                
                Group {
                    //Image Captions for the shop
                    
                    VStack(alignment: .leading) {
                        Divider()
                        
                        
                        ForEach(0 ..< captionViewModel.caption.count, id: \.self) {
                            AsyncImage(url: URL(string: captionViewModel.caption[$0].imageURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.purple.opacity(0)
                            }
                            .frame(width: 300, height: 200)
                            .padding()
                            
                            Text(captionViewModel.caption[$0].caption).padding()
                            Divider()
                        }
                    }.onAppear(){
                        self.captionViewModel.fetchCaptions(shopID: place.id)
                        print("Data are appeared.")
                    }
                    .onDisappear(){
                        print("Data are disappeared.")
                    }
                }
                
            }.padding()
                .navigationTitle(place.name)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                                        HStack {
                    
                    Link(destination: url) {
                        Image(systemName: "link")
                    }
                    
                    
                    if #available(iOS 16.0, *) {
                        ShareLink(item: url, subject: Text("Check It Out!"), message:Text(message)) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    } else {
                        // Fallback on earlier versions
                        Button(action: {
                            isShareSheetDisplay.toggle()
                            
                            let text = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                            
                            UIApplication.shared.windows.first?
                                .rootViewController?.present(text, animated: true,
                                                             completion: nil)
                            
                        }) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    
                    
                    Button(action: {
                        self.isShownPostView = true
                    }) {
                        Image(systemName: "square.and.pencil")
                    }.onTapGesture {
                        self.isShownPostView = true
                    }
                    .sheet(isPresented: $isShownPostView) {
                        PostCaptionView(shopID: place.id)
                    }
                    
                    
                }
                                    
                )
        }
        
        
    }
}

struct LocationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let place = PlaceCol(id: "1000", name: "Paper Lanterns Places", address: "Flat 5, 10/F, Kam Shing Building, 12 Wang Hoi Road, Kowloon Bay", description: "Paper Lanterns Places", district: "Kowloon Bay", website: "https://web.whatsapp.com", telephone: "98674321", email: "abc@gmail.com", latitude: 22.322946, longitude: 114.21071, mainImgURL: "google.com")
        LocationInfoView(place: place)
    }
}
