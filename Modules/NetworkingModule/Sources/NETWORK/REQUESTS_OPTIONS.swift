//
//  REQUESTS_OPTIONS.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

public struct RequestOptions {
    var headers: [String: String]?
    var parameters: [String: Any]?
    var body: Data?
    var authorization: Authorization
    var preRequestScript: (() -> Void)?

    public init(headers: [String: String]? = nil, parameters: [String: Any]? = nil, body: Data? = nil, authorization: Authorization = .none, preRequestScript: (() -> Void)? = nil) {
        self.headers = headers
        self.parameters = parameters
        self.body = body
        self.authorization = authorization
        self.preRequestScript = preRequestScript
    }
}
