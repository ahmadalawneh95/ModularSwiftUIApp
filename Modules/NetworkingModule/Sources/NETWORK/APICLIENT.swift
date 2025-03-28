//
//  APICLIENT.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import Foundation
import RxSwift

public class APIClient {
    public static let shared = APIClient()
    private init() {}

    // Request method with URL, HTTPMethod, and RequestOptions
    public func request<T: Decodable>(endpoint: URLConfig.Endpoint, method: HTTPMethod, options: RequestOptions? = nil) -> Observable<T> {
        let urlConfig = URLConfig()
        
        // Get the full URL for the endpoint
        let url = urlConfig.getEndpointURL(for: endpoint)
        
        // Generate the cURL command before making the actual request
        printCurlCommand(url: url, method: method, headers: options?.headers, body: options?.body)
        
        // Return observable for the request
        return Observable.create { observer in
            // Execute pre-request script if provided
            options?.preRequestScript?()

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue

            // Add headers if provided
            if let headers = options?.headers {
                for (key, value) in headers {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }

            // Add authorization header if provided
            if let authHeaderValue = options?.authorization.headerValue {
                request.setValue(authHeaderValue, forHTTPHeaderField: "Authorization")
            }

            // Add parameters as URL query for GET requests
            if let parameters = options?.parameters, method == .GET {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = components?.url
            }

            // Add body for POST, PUT, DELETE methods
            if let body = options?.body, method != .GET {
                request.httpBody = body
            }

            // Perform the network request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(decodedData)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            task.resume()
            
            // Return a disposable to cancel the request if needed
            return Disposables.create { task.cancel() }
        }
    }

    // Function to print cURL command
    private func printCurlCommand(url: URL, method: HTTPMethod, headers: [String: String]?, body: Data?) {
        var curlCommand = "curl -X \(method.rawValue) \"\(url.absoluteString)\""
        
        // Add headers to cURL command
        if let headers = headers {
            for (key, value) in headers {
                curlCommand += " -H \"\(key): \(value)\""
            }
        }

        // Add body to cURL command if exists (for POST/PUT/DELETE requests)
        if let body = body {
            if let bodyString = String(data: body, encoding: .utf8) {
                curlCommand += " -d \"\(bodyString)\""
            }
        }
        
        // Print the cURL command
        print("Generated cURL command: \(curlCommand)")
    }
}
