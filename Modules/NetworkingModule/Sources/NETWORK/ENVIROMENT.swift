//
//  ENVIROMENT.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import Foundation

//https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-summary
//https://yahoo-finance-real-time1.p.rapidapi.com/market/get-summary?region=US
// Enum to represent different environments (Schemes)
public enum Environment {
    case production
    case staging
    case development

    // Method to return the base URL based on the environment
    var baseURL: String {
        switch self {
        case .production:
            return "https://yahoo-finance-real-time1.p.rapidapi.com/"
        case .staging:
            return "https://yahoo-finance-real-time1.p.rapidapi.com/"
        case .development:
            return "https://yahoo-finance-real-time1.p.rapidapi.com/"
        }
    }
}

// Struct to manage both base URL and endpoints for various schemes
public struct URLConfig {

    // Store the environment in which we are working
    private var environment: Environment

    // Define the endpoints for each environment
    public enum Endpoint {
        case market
        case stock

        // Method to return the full URL for each endpoint
        func url(withBaseURL baseURL: String) -> URL {
            switch self {
            case .market:
                return URL(string: baseURL + "market/get-summary")!
            case .stock:
                return URL(string: baseURL + "stock/get-summary")!
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
