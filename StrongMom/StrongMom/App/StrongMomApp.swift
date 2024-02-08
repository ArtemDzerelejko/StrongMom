//
//  StrongMomApp.swift
//  StrongMom
//
//  Created by artem on 16.01.2024.
//

import SwiftUI
import UIKit

@main
struct StrongMomApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
