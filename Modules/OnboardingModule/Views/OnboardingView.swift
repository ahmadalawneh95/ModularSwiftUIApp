//
//  OnboardingView.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import SwiftUI
import Resolver
import CoreModule

public struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel = Resolver.resolve()

    public init() {}

    public var body: some View {
        VStack {
            List(viewModel.onboardingData, id: \.self) { item in
                Text(item)
            }
            PrimaryButton(title: LocalizedStrings.shared.localized("Continue")) {
                viewModel.fetchOnboardingData()
            }
        }
    }
}
