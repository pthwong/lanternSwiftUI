//
//  EnquiryView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import SwiftUI
import MapKit

struct EnquiryView: View {
    @State var isSheetPresented = false
    
    @EnvironmentObject var locationSearchModel: LocationSearchModel
    
    var body: some View {
        
        VStack {
            
            Button("Show Places' name") {
                isSheetPresented.toggle()
            }

            Map(coordinateRegion: $locationSearchModel.region, showsUserLocation: true, annotationItems: locationSearchModel.landmarks) { landmark in
                
                MapAnnotation(coordinate: landmark.locationCoordinate) {
                    Image(systemName: "heart.fill")
                }
                
            }
            
                .sheet(isPresented: $isSheetPresented) {
                    if #available(iOS 16.0, *) {
                        LocationListView().presentationDetents([.medium, .large])
                    }
                }
        
        }
//        ScrollView {
//            MapView()
//                .ignoresSafeArea(edges: .top)
//                .frame(height: 500)
//
//                .sheet(isPresented: $isSheetPresented) {
//                    if #available(iOS 16.0, *) {
//                        LocationListView().presentationDetents([.medium, .large])
//                    }
//                }
//
//            VStack(alignment: .leading) {
//                List(lanternLocation) { location in
//                    VStack(alignment: .leading) {
//                        Text(location.name).font(.title3).bold()
//                        Text(location.address).font(.caption)
//                        Text(location.description).font(.caption)
//                    }
//                }
//
//
//                Text("Turtle Rock")
//                    .font(.title)
//
//                HStack {
//                    Text("Joshua Tree National Park")
//                    Spacer()
//                    Text("California")
//                }
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//
//                Divider()
//
//                Text("About Turtle Rock")
//                    .font(.title2)
//                Text("Descriptive text goes here.")
//            }
//            .padding()

//        }
        


        
    }
}

struct EnquiryView_Previews: PreviewProvider {
    static var previews: some View {
        EnquiryView().environmentObject(LocationSearchModel())
    }
}
