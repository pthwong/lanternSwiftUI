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
    
    @State private var isPresentedImagePicker = false
    @State private var isPresentedActionScheet = false
    @State private var isPresentedCamera = false
    
    @State var imageURLList = [String]()

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
                
                Group {
                    HStack {
                        Image(uiImage: image ?? placeholder)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipped()
                        
                        Spacer()
                        
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
                        Image(systemName: "phone.fill").font(.title3)
                        Text("\(place.telephone)")
                    }.font(.subheadline)
                        .padding()
                    
                    
                    HStack {
                        Image(systemName: "envelope.fill").font(.title3)
                        Text(place.email)
                    }.font(.subheadline)
                        .padding()
                }
                

                Divider()
                
                
                Group {
                    Text("About \(place.name)")
                        .font(.title2).bold().padding()
                    
                    
                    Text(place.description).padding()
                    
                }
                    Divider()
                
                Group {
                    Text("Comments")
                        .font(.title2).bold().padding()
                    /*
                    //Card View of comments
                    VStack {
                        Image(uiImage: placeholder ?? placeholder)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 100)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Hello World")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Text("Very Good")
                                    .font(.title3).bold()
                                    .foregroundColor(.primary)
                                    .lineLimit(3)
                                Text("Good Taste")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .layoutPriority(100)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .shadow(radius: 5)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                    
                    )
                    .padding([.top, .horizontal])
                     */
                    
                    
                }
                
            }.padding()
                .navigationTitle(place.name)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                 HStack {
                    
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
                            Image(systemName: "square.and.arrow.up").font(.title2).padding()
                        }
                    }
                    
                    
                    Button(action: {
//                        print("add button")
                        self.isPresentedActionScheet = true
                    }) {
                        Image(systemName: "square.and.pencil")
                    }.onTapGesture {
                        self.isPresentedActionScheet = true
                    }
                    .sheet(isPresented: $isPresentedImagePicker) {
//                        ImagePickerViewModel(sourceType: self.isPresentedCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$isPresentedImagePicker)
                        ImagePickerController(sourceType: self.isPresentedCamera ? .camera : .photoLibrary, isPresented: self.$isPresentedImagePicker, imageURLList: $imageURLList)
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
                
                )
        }
        
        
    }
}

struct LocationInfoViewFB_Previews: PreviewProvider {
    static var previews: some View {
        LocationInfoViewFB(place: PlaceColFB(id: "1000", name: "Paper Lanterns Places", address: "Flat 5, 10/F, Kam Shing Building, 12 Wang Hoi Road, Kowloon Bay", description: "Paper Lanterns Places", district: "Kowloon Bay", website: "https://web.whatsapp.com", telephone: "98674321", email: "abc@gmail.com", latitude: 22.322946, longitude: 114.21071, mainImgPath: "mainImg/1000.jpg"))
    }
}
