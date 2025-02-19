//
//  Endpoints.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import Foundation

public enum Endpoints {
    case onboarding
    case registration

    var url: String {
        switch self {
        case .onboarding:
            return "https://api.example.com/onboarding"
        case .registration:
            return "https://api.example.com/registration"
        }
    }
}
