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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
