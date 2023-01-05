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
                    .font(.title).bold()
                
                HStack {
                    Text(locations.address)
                    Spacer()
                    Text(locations.district)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About \(locations.name)")
                    .font(.title2).bold()
                Text(locations.description)
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
