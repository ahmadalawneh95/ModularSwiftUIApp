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

    public func request<T: Decodable>(
        endpoint: URLConfig.Endpoint,
        method: HTTPMethod,
        options: RequestOptions? = nil,
        loaderManager: LoaderManager? = nil // Now using public LoaderManager
    ) -> Observable<T> {
        let urlConfig = URLConfig()
        let url = urlConfig.getEndpointURL(for: endpoint)

        printCurlCommand(url: url, method: method, headers: options?.headers, body: options?.body)
        
        return Observable.create { observer in
            // Start loader if provided
            loaderManager?.startLoading()

            options?.preRequestScript?()

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue

            if let headers = options?.headers {
                for (key, value) in headers {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }

            if let authHeaderValue = options?.authorization.headerValue {
                request.setValue(authHeaderValue, forHTTPHeaderField: "Authorization")
            }

            if let parameters = options?.parameters, method == .GET {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = components?.url
            }

            if let body = options?.body, method != .GET {
                request.httpBody = body
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // Stop loader
                loaderManager?.stopLoading()

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
            
            return Disposables.create {
                task.cancel()
                loaderManager?.stopLoading()
            }
        }
    }

    private func printCurlCommand(url: URL, method: HTTPMethod, headers: [String: String]?, body: Data?) {
        var curlCommand = "curl -X \(method.rawValue) \"\(url.absoluteString)\""
        
        if let headers = headers {
            for (key, value) in headers {
                curlCommand += " -H \"\(key): \(value)\""
            }
        }

        if let body = body, let bodyString = String(data: body, encoding: .utf8) {
            curlCommand += " -d \"\(bodyString)\""
        }
        
        print("Generated cURL command: \(curlCommand)")
    }
}
