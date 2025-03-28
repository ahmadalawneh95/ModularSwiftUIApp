import Foundation
import NetworkingModule
import RxSwift

class StockViewModel: ObservableObject {
    @Published var marketSummary: MarketSummaryResponse?
    private let disposeBag = DisposeBag() // Keep DisposeBag as a property

    func getStocks() {
        let options = RequestOptions(
            headers: ["x-rapidapi-key": "xn7im5uD2fmshoCcOEonH8PMIePMp1WbtYAjsnE0v5SXTBGoXx",
                      "x-rapidapi-host": "yahoo-finance-real-time1.p.rapidapi.com"],
            parameters: ["region": "US"]
        )

        APIClient.shared.request(endpoint: .market, method: .GET, options: options)
            .observe(on: MainScheduler.instance) // Ensure UI updates happen on the main thread
            .subscribe(
                onNext: { [weak self] (stocks: MarketSummaryResponse) in
                    self?.marketSummary = stocks
                },
                onError: { error in
                    print("Error: \(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}
// MARK: - Stocks
struct MarketSummaryResponse: Codable {
    let marketSummaryResponse: MarketSummaryResult?
}

struct MarketSummaryResult: Codable {
    let result: [MarketSummary]?
}

struct MarketSummary: Identifiable, Codable {
    let id = UUID()
    let symbol: String?
    let shortName: String?
    let regularMarketPrice: NumericValue?
    let regularMarketChangePercent: NumericValue?
}

struct NumericValue: Codable {
    let raw: Double?
    let fmt: String?
}
