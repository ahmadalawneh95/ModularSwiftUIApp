import SwiftUI
import Combine

public struct OnboardingView: View {
    @StateObject private var viewModel = StockViewModel()
    @State private var searchText = ""
    @State private var timer: AnyCancellable?
    @State private var isNavigating = false
    @State private var selectedStockSymbol: String?

    public init() {}

    public var body: some View {
        NavigationView {
            VStack {
                Text("Stock Market Overview")
                    .font(.largeTitle)
                    .padding()

                TextField("Search Stocks", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if let stocks = viewModel.marketSummary?.marketSummaryResponse?.result, !stocks.isEmpty {
                    List(stocks.filter { stock in
                        searchText.isEmpty || (stock.shortName?.lowercased().contains(searchText.lowercased()) ?? false)
                    }) { stock in
                        Button(action: {
                            // Trigger the API call when stock is tapped
                            fetchStockDetails(symbol: stock.symbol ?? "")
                        }) {
                            VStack(alignment: .leading) {
                                Text(stock.shortName ?? stock.symbol ?? "N/A")
                                    .font(.headline)
                                Text("Price: $\(stock.regularMarketPrice?.raw ?? 0.0, specifier: "%.2f")")
                                Text("Change: \(stock.regularMarketChangePercent?.raw ?? 0.0, specifier: "%.2f")%")
                                    .foregroundColor((stock.regularMarketChangePercent?.raw ?? 0.0) >= 0 ? .green : .red)
                            }
                        }
                        .background(
                            NavigationLink(
                                destination: StockDetailView(viewModel: viewModel, symbol: selectedStockSymbol ?? ""),
                                isActive: $isNavigating
                            ) {
                                EmptyView()
                            }
                            .hidden() // Hide the NavigationLink, we will manually activate it
                        )
                    }
                } else {
                    Text("No stocks available.")
                        .foregroundColor(.gray)
                }

                Button("Continue") {
                    print("Onboarding Completed")
                }
                .padding()
            }
            .onAppear {
                viewModel.getMarketSummary() // Initial API call to get market summary
                timer = Timer.publish(every: 8, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        viewModel.getMarketSummary() // Periodic refresh every 8 seconds
                    }
            }
            .onDisappear {
                timer?.cancel()
            }
        }
    }

    private func fetchStockDetails(symbol: String) {
        // Trigger the API call to fetch stock data before navigating
        viewModel.getStocks(symbol: symbol) { result in
            switch result {
            case .success(let stock):
                // Successfully fetched stock data
                self.selectedStockSymbol = symbol
                self.isNavigating = true // Trigger navigation to StockDetailView
            case .failure(let error):
                // Handle the error (e.g., show an alert)
                print("Error fetching stock: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    OnboardingView()
}
