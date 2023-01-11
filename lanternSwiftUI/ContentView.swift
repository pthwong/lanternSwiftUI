//
//  ContentView.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LocationListView().tabItem({
                Image(systemName: "house.fill")
            })
            MapView().tabItem({
                Image(systemName: "map")
            })
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
            .previewDisplayName("iPad Pro (11-inch) (4th generation)")
    }
}
