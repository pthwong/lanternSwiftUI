//
//  EnquiryView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import SwiftUI
import CoreLocation
import MapKit


struct EnquiryView: View {
    @State private var isSheetPresented = false
    
    @StateObject private var locationManager = LocationManager()
    
    @State private var isShow = false
    
    var body: some View {
        
        VStack {
            
            Button(action: {
                isSheetPresented.toggle()
            }) {
                Image(systemName: "list.bullet").font(.largeTitle).padding()
            }
  
            MapView()
            
            
            
                .sheet(isPresented: $isSheetPresented) {
                    if #available(iOS 16.0, *) {
                        LocationListView().presentationDetents([.medium, .large])
                    }
                    else {
                        LocationListView()
                    }
                }
            
        }


        
    }
}

struct EnquiryView_Previews: PreviewProvider {
    static var previews: some View {
        EnquiryView()
    }
}
