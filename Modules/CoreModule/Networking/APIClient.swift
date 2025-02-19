//
//  APIClient.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import Foundation
import RxSwift

public protocol APIClientProtocol {
    func request<T: Decodable>(endpoint: Endpoints, method: HTTPMethod, parameters: [String: Any]?) -> Observable<T>
}

public class APIClient: APIClientProtocol {
    public static let shared = APIClient()

    public func request<T: Decodable>(endpoint: Endpoints, method: HTTPMethod, parameters: [String: Any]? = nil) -> Observable<T> {
        return Observable.create { observer in
            guard let url = URL(string: endpoint.url) else {
                observer.onError(NSError(domain: "Invalid URL", code: 0))
                return Disposables.create()
            }

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            if let parameters = parameters {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            }

            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    observer.onError(error ?? NSError(domain: "Request failed", code: 0))
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(decodedData)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }

            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
