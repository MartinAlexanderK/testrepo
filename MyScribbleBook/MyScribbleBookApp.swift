//
//  MyScribbleBookApp.swift
//  MyScribbleBook
//
//  Created by Martin Kaeser on 20.07.23.
//

import SwiftUI
import Firebase




@main
struct MyScribbleBookApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            RootView()
//                ProductsView()

            
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
