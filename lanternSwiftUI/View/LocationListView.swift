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
                HStack {
                    Text(location.name)
                }
            }
        }.navigationTitle("Lantern Locations")
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
