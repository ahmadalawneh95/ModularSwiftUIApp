//
//  MarketSummaryResponse.swift
//  Pods
//
//  Created by Ahmad Alawneh on 28/03/2025.
//

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
