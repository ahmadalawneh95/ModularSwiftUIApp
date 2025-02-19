//
//  ENVIROMENT.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import Foundation

// Enum to represent different environments (Schemes)
public enum Environment {
    case production
    case staging
    case development

    // Method to return the base URL based on the environment
    var baseURL: String {
        switch self {
        case .production:
            return "https://api.production.com"
        case .staging:
            return "https://api.staging.com"
        case .development:
            return "https://api.development.com"
        }
    }
}

// Struct to manage both base URL and endpoints for various schemes
public struct URLConfig {

    // Store the environment in which we are working
    private var environment: Environment

    // Define the endpoints for each environment
    public enum Endpoint {
        case users
        case posts
        case comments

        // Method to return the full URL for each endpoint
        func url(withBaseURL baseURL: String) -> URL {
            switch self {
            case .users:
                return URL(string: baseURL + "/users")!
            case .posts:
                return URL(string: baseURL + "/posts")!
            case .comments:
                return URL(string: baseURL + "/comments")!
            }
        }
    }

    // Initialize URLConfig based on the selected scheme/environment
    public init() {
        // Automatically detect the build configuration and select the appropriate environment
        #if DEBUG
        self.environment = .development
        #elseif STAGING
        self.environment = .staging
        #else
        self.environment = .production
        #endif
    }

    // Method to get the base URL based on the current environment
    public func getBaseURL() -> String {
        return self.environment.baseURL
    }

    // Method to get the full URL for a specific endpoint
    public func getEndpointURL(for endpoint: Endpoint) -> URL {
        return endpoint.url(withBaseURL: getBaseURL())
    }
}
