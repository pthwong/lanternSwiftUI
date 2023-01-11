//
//  lanternSwiftUIApp.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import SwiftUI
import Firebase
import FirebaseCore

//Source of the app icon: https://www.flaticon.com/free-icon/lantern_9362571?related_id=9362571

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}



@main
struct lanternSwiftUIApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
