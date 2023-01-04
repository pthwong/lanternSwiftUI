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
                VStack(alignment: .leading) {
                        Text(location.name).font(.title3).bold()
                        Text(location.address).font(.caption)
                        Text(location.description).font(.caption)
                    }
            }.navigationTitle("Lantern Locations")
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
