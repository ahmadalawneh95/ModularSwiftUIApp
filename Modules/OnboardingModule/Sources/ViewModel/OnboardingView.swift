import SwiftUI
import Combine

public struct OnboardingView: View {
    @StateObject private var viewModel = StockViewModel()
    @State private var searchText = ""
    @State private var timer: AnyCancellable?

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

                // Safely unwrap the optional stocks array
                if let stocks = viewModel.marketSummary?.marketSummaryResponse?.result, !stocks.isEmpty {
                    List(stocks.filter { stock in
                        searchText.isEmpty || (stock.shortName?.lowercased().contains(searchText.lowercased()) ?? false)
                    }) { stock in
                        VStack(alignment: .leading) {
                            // Safely unwrap or provide defaults for optional values
                            Text(stock.shortName ?? stock.symbol ?? "N/A")
                                .font(.headline)
                            Text("Price: $\(stock.regularMarketPrice?.raw ?? 0.0, specifier: "%.2f")")
                            Text("Change: \(stock.regularMarketChangePercent?.raw ?? 0.0, specifier: "%.2f")%")
                                .foregroundColor((stock.regularMarketChangePercent?.raw ?? 0.0) >= 0 ? .green : .red)
                        }
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
                viewModel.getStocks() // Initial API call
                timer = Timer.publish(every: 8, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        viewModel.getStocks() // Periodic refresh every 8 seconds
                    }
            }
            .onDisappear {
                timer?.cancel()
            }
        }
    }
}

#Preview {
    OnboardingView()
}
