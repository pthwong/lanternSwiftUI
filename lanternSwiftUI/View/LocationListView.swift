//
//  LocationListView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import SwiftUI

struct LocationListView: View {
    
    var body: some View {
        NavigationView {
            List(lanternLocation) { location in
                NavigationLink(destination: LocationInfoView()) {
                    VStack(alignment: .leading) {
                        Text(location.name).font(.title3).bold()
                        Text(location.address).opacity(0.6)
                        Text(location.description).font(.caption)
                    }
                }
            }
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
