//
//  LocationInfoView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 5/1/2023.
//

import SwiftUI
import MapKit


struct LocationInfoView: View {
    var locations: AnnotatedItem
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(locations.name)
                    .font(.title)
                    .bold()
                    .padding()
                
//                HStack {
//                    Text(locations.address)
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//
//                }
                
                Divider()
                
                HStack {
                    Text("Address: ")
                    Spacer()
                    Text(locations.address)
                }.font(.subheadline)
                    .padding()
                
                
                HStack {
                    Text("Email: ")
                    Spacer()
                    Text(locations.email)
                }.font(.subheadline)
                    .padding()
        
                
                HStack {
                    Text("Website: ")
                    Spacer()
                    Text(locations.website)
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
//        VStack(alignment: .leading) {
//            Text("Name")
//                .font(.title).bold()
//
//            HStack {
//                Text("Address")
//                Spacer()
//                Text("District")
//            }
//            .font(.subheadline)
//            .foregroundColor(.secondary)
//
//            Divider()
//
//            Text("About name")
//                .font(.title2)
//            Text("Descrption")
//        }.padding()
//        .navigationTitle("Place")
//        .navigationBarTitleDisplayMode(.inline)
        
        
        
    }
}

struct LocationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInfoView(locations: lanternLocation[1])
    }
}
