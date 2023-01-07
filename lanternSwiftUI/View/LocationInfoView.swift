//
//  LocationInfoView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 5/1/2023.
//

import SwiftUI


struct LocationInfoView: View {
    var locations: AnnotatedItem
    
    @State private var isShareSheetDisplay = false
    
    
    var body: some View {
        let url = URL(string: locations.website)!
        let message = "\n\nHere are the information of Paper Lantern Shop:\nName: \(locations.name) \nAddress: \(locations.address) \nPhone: \(locations.telephone) \nEmail: \(locations.email)\n \nCheck it out!"
        
        ScrollView {
            VStack(alignment: .leading) {
                Text(locations.name)
                    .font(.title)
                    .bold()
                    .padding()

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
                    Text(locations.address)
                }.font(.subheadline)
                    .padding()
                
                HStack {
                    Image(systemName: "phone.fill").font(.title3)
                    Text("\(locations.telephone)")
                }.font(.subheadline)
                    .padding()
                
                
                HStack {
                    Image(systemName: "envelope.fill").font(.title3)
                    Text(locations.email)
                }.font(.subheadline)
                    .padding()
                
                
                Divider()
                
                Text("About \(locations.name)")
                    .font(.title2).bold().padding()
                
                
                Text(locations.description).padding()
                
                
                
            }.padding()
                .navigationTitle(locations.name)
                .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

struct LocationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInfoView(locations: lanternLocation[1])
    }
}
