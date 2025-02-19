//
//  AUTHORIZATIONS_TYPES.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

public enum Authorization {
    case bearer(String)  // Token-based authentication (Bearer Token)
    case basic(username: String, password: String)  // Basic Authentication (username:password)
    case apiKey(String)  // API Key authentication
    case none  // No authorization

    var headerValue: String? {
        switch self {
        case .bearer(let token):
            return "Bearer \(token)"
        case .basic(let username, let password):
            let loginString = "\(username):\(password)"
            guard let loginData = loginString.data(using: .utf8) else { return nil }
            return "Basic \(loginData.base64EncodedString())"
        case .apiKey(let apiKey):
            return apiKey
        case .none:
            return nil
        }
    }
}
