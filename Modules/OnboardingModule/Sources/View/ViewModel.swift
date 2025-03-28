import Foundation
import NetworkingModule
import RxSwift

class StockViewModel: ObservableObject {
    @Published var marketSummary: MarketSummaryResponse?
    @Published  var stockDetail: Stock?
    private let disposeBag = DisposeBag() // Keep DisposeBag as a property

    func getMarketSummary() {
        let options = RequestOptions(
            headers: ["x-rapidapi-key": "xn7im5uD2fmshoCcOEonH8PMIePMp1WbtYAjsnE0v5SXTBGoXx",
                      "x-rapidapi-host": "yahoo-finance-real-time1.p.rapidapi.com"],
            parameters: ["region": "US"]
        )

        APIClient.shared.request(endpoint: .market, method: .GET, options: options)
            .observe(on: MainScheduler.instance) // Ensure UI updates happen on the main thread
            .subscribe(
                onNext: { [weak self] (marketSummary: MarketSummaryResponse) in
                    self?.marketSummary = marketSummary
                },
                onError: { error in
                    print("Error: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func getStocks(symbol: String, completion: @escaping (Result<Stock, Error>) -> Void) {
        let options = RequestOptions(
            headers: ["x-rapidapi-key": "xn7im5uD2fmshoCcOEonH8PMIePMp1WbtYAjsnE0v5SXTBGoXx",
                      "x-rapidapi-host": "yahoo-finance-real-time1.p.rapidapi.com"],
            parameters: ["lang":"en-US","symbol":symbol,"region": "US"]
        )

        APIClient.shared.request(endpoint: .stock, method: .GET, options: options)
            .observe(on: MainScheduler.instance) // Ensure UI updates happen on the main thread
            .subscribe(
                onNext: { [weak self] (stocks: Stock) in
                    self?.stockDetail = stocks
                    completion(.success(stocks)) // Success case: return the fetched Stock object
                },
                onError: { error in
                    print("Error: \(error)")
                    completion(.failure(error)) // Failure case: return the error
                }
            )
            .disposed(by: disposeBag)
    }

}
