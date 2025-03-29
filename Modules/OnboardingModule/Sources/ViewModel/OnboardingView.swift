import SwiftUI
import Combine
import NetworkingModule

public struct OnboardingView: View {
    @StateObject private var viewModel = StockViewModel()
    @StateObject private var loaderManager = LoaderManager()
    @State private var searchText = ""
    @State private var timer: AnyCancellable?
    @State private var isNavigating = false
    @State private var selectedStockSymbol: String?
    @State private var isLoading = true // ✅ Track loading state

    public init() {}

    public var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Stock Market Overview")
                        .font(.largeTitle)
                        .padding()

                    TextField("Search Stocks", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    if isLoading {
                        // ✅ Show Skeleton Loader
                        SkeletonView()
                    } else {
                        // ✅ Show actual data once loaded
                        if let stocks = viewModel.marketSummary?.marketSummaryResponse?.result, !stocks.isEmpty {
                            List(stocks.filter { stock in
                                searchText.isEmpty || (stock.shortName?.lowercased().contains(searchText.lowercased()) ?? false)
                            }) { stock in
                                Button(action: {
                                    print("Fetching details for: \(stock.symbol ?? "Unknown")")
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
                            }
                        } else {
                            Text("No stocks available.")
                                .foregroundColor(.gray)
                        }
                    }

                    Button("Continue") {
                        print("Onboarding Completed")
                    }
                    .padding()
                }
                .onAppear {
                    print("Fetching market summary...")
                    viewModel.getMarketSummary()
                    timer = Timer.publish(every: 8, on: .main, in: .common)
                        .autoconnect()
                        .sink { _ in
                            print("Refreshing market summary...")
                            viewModel.getMarketSummary()
                        }

                    // ✅ Delay setting isLoading to false when data is received
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading = false
                    }
                }
                .onDisappear {
                    timer?.cancel()
                }

                NavigationLink(
                    destination: selectedStockSymbol.map { StockDetailView(viewModel: viewModel, symbol: $0) },
                    isActive: $isNavigating
                ) {
                    EmptyView()
                }
                .hidden()

                if loaderManager.isLoading {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView("Loading...")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
    }

    private func fetchStockDetails(symbol: String) {
        DispatchQueue.main.async {
            loaderManager.startLoading()
        }

        viewModel.getStocks(symbol: symbol) { result in
            DispatchQueue.main.async {
                loaderManager.stopLoading()
                switch result {
                case .success(let stock):
                    print("Stock details loaded: \(stock)")
                    self.selectedStockSymbol = symbol
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.isNavigating = true
                    }
                case .failure(let error):
                    print("Error fetching stock: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
