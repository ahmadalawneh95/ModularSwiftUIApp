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

    public func request<T: Decodable>(url: URL, method: HTTPMethod, options: RequestOptions? = nil) -> Observable<T> {
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

            // Add body for POST, PUT, DELETE
            if let body = options?.body, method != .GET {
                request.httpBody = body
            }

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
            return Disposables.create { task.cancel() }
        }
    }
}
