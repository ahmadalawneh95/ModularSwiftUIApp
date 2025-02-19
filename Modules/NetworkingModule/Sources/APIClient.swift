import Foundation
import RxSwift

public class APIClient {
    public static let shared = APIClient()
    private init() {}

    public func request<T: Decodable>(url: URL, method: String) -> Observable<T> {
        return Observable.create { observer in
            var request = URLRequest(url: url)
            request.httpMethod = method

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

