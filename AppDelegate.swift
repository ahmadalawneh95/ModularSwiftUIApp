//
//  AppDelegate.swift
//  ModularSwiftUIApp
//
//  Created by Ahmad Alawneh on 29/03/2025.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if ProcessInfo.processInfo.arguments.contains("-ui-testing") {
            // Configure for UI tests
            UIView.setAnimationsEnabled(false)
            // Setup mock API responses
        }
        
        return true
    }
}
