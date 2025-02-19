//
//  ModularSwiftUIAppApp.swift
//  ModularSwiftUIApp
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import SwiftUI
import OnboardingModule

@main
struct ModularSwiftUIAppApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            OnboardingView() // Load Onboarding as the first screen
        }
    }
}
