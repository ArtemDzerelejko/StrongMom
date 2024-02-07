//
//  StrongMomApp.swift
//  StrongMom
//
//  Created by artem on 16.01.2024.
//

import SwiftUI
import UIKit

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     continue userActivity: NSUserActivity,
//                     restorationHandler:
//                     @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        print("test")
//        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
//              let url = userActivity.webpageURL,
//              let components = URLComponents(url: url,
//                                             resolvingAgainstBaseURL: true) else {
//            return false
//         
//        }
//        return true
//    }
//    
//    func application(_ application: UIApplication,
//                         open url: URL,
//                         options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        print(url)
//        return true
//
//        /// Handle the URL property accordingly
//    }
    
//    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
//            guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
//              let url = userActivity.webpageURL,
//              let components = URLComponents(url: url,
//                                             resolvingAgainstBaseURL: true) else {
//                return
//            }
//        }
//}

@main
struct StrongMomApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
