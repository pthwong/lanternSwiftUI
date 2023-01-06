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
            EnquiryView().tabItem({
                Image(systemName: "house.fill")
            })
//            LocationListView().tabItem({
//                Image(systemName: "map")
//            })
            BookmarkView().tabItem({
                Image(systemName: "bookmark")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
