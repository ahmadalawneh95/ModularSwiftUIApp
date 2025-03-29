//
//  StockDetailView.swift
//  Pods
//
//  Created by Ahmad Alawneh on 28/03/2025.
//

import SwiftUI

struct StockDetailView: View {
    var viewModel: StockViewModel?
    var symbol: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                let companyName = viewModel?.stockDetail?.quoteType?.longName ?? "Unknown"
                let currentPrice = viewModel?.stockDetail?.price?.regularMarketPrice ?? 0.0
                let priceChange = viewModel?.stockDetail?.price?.regularMarketChange ?? 0.0
                let priceChangePercent = viewModel?.stockDetail?.price?.regularMarketChangePercent ?? 0.0
                
                VStack(alignment: .leading) {
                    Text(companyName)
                        .font(.title)
                        .bold()
                    
                    HStack(alignment: .lastTextBaseline, spacing: 8) {
                        Text("$\(currentPrice, specifier: "%.2f")")
                            .font(.system(size: 32, weight: .bold))
                        
                        Text("\(priceChange > 0 ? "+" : "")\(priceChange, specifier: "%.2f")")
                            .foregroundColor(priceChange >= 0 ? .green : .red)
                        
                        Text("(\(priceChange > 0 ? "+" : "")\(priceChangePercent * 100, specifier: "%.2f")%)")
                            .foregroundColor(priceChange >= 0 ? .green : .red)
                    }
                }
                .padding(.bottom)
                
                let low52Week = viewModel?.stockDetail?.summaryDetail?.fiftyTwoWeekLow ?? 0.0
                let high52Week = viewModel?.stockDetail?.summaryDetail?.fiftyTwoWeekHigh ?? 0.0
                let averageVolume = viewModel?.stockDetail?.summaryDetail?.regularMarketVolume ?? 0
                
                VStack(spacing: 12) {
                    HStack {
                        Text("52 Week Range")
                        Spacer()
                        Text("$\(low52Week, specifier: "%.2f") - $\(high52Week, specifier: "%.2f")")
                            .bold()
                    }
                    
                    HStack {
                        Text("Avg Volume")
                        Spacer()
                        Text("\(averageVolume.formatted(.number.notation(.compactName)))")
                            .bold()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                let about = viewModel?.stockDetail?.summaryProfile?.industry ?? "No description available."
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("About")
                        .font(.headline)
                    
                    Text(about)
                        .font(.subheadline)
                        .lineSpacing(4)
                }
                .padding(.top)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(viewModel?.stockDetail?.symbol ?? "")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    StockDetailView(viewModel: nil, symbol: "")
}
