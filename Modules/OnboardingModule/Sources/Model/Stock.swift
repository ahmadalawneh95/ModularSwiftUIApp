//
//  Stock.swift
//  Pods
//
//  Created by Ahmad Alawneh on 28/03/2025.
//

struct Stock: Codable {
    let recommendationTrend: RecommendationTrend?
    let institutionOwnership: InstitutionOwnership?
    let majorHoldersBreakdown: MajorHoldersBreakdown?
    let majorDirectHolders: MajorDirectHolders?
    let defaultKeyStatistics: DefaultKeyStatistics?
    let summaryProfile: SummaryProfile?
    let netSharePurchaseActivity: NetSharePurchaseActivity?
    let insiderTransactions: InsiderTransactions?
    let financialsTemplate: FinancialsTemplate?
    let quoteType: QuoteType?
    let fundOwnership: FundOwnership?
    let summaryDetail: SummaryDetail?
    let insiderHolders: InsiderHolders?
    let earnings: Earnings?
    let calendarEvents: CalendarEvents?
    let upgradeDowngradeHistory: UpgradeDowngradeHistory?
    let pageViews: PageViews?
    let price: Price?
    let financialData: FinancialData?
    let symbol: String?
    
    // Nested structs
    struct RecommendationTrend: Codable {
        let trend: [Trend]?
        let maxAge: Int?
        
        struct Trend: Codable {
            let period: String?
            let strongBuy: Int?
            let buy: Int?
            let hold: Int?
            let sell: Int?
            let strongSell: Int?
        }
    }
    
    struct InstitutionOwnership: Codable {
        let maxAge: Int?
        let ownershipList: [Ownership]?
        
        struct Ownership: Codable {
            let maxAge: Int?
            let reportDate: DateData?
            let organization: String?
            let pctHeld: ValueData?
            let position: ValueData?
            let value: ValueData?
            let pctChange: ValueData?
            
            struct DateData: Codable {
                let raw: Int?
                let fmt: String?
            }
            
            struct ValueData: Codable {
                let raw: Double?
                let fmt: String?
                let longFmt: String?
            }
        }
    }
    
    struct MajorHoldersBreakdown: Codable {
        let maxAge: Int?
        let insidersPercentHeld: Double?
        let institutionsPercentHeld: Double?
        let institutionsFloatPercentHeld: Double?
        let institutionsCount: Int?
    }
    
    struct MajorDirectHolders: Codable {
        let holders: [String]?
        let maxAge: Int?
    }
    
    struct DefaultKeyStatistics: Codable {
        let maxAge: Int?
        let priceHint: Int?
        let enterpriseValue: Int?
        let forwardPE: Double?
        let profitMargins: Double?
        let floatShares: Int?
        let sharesOutstanding: Int?
        let sharesShort: Int?
        let sharesShortPriorMonth: Int?
        let sharesShortPreviousMonthDate: DateData?
        let dateShortInterest: DateData?
        let sharesPercentSharesOut: Double?
        let heldPercentInsiders: Double?
        let heldPercentInstitutions: Double?
        let shortRatio: Double?
        let shortPercentOfFloat: Double?
        let beta: Double?
        let impliedSharesOutstanding: Int?
        let category: String?
        let bookValue: Double?
        let priceToBook: Double?
        let fundFamily: String?
        let legalType: String?
        let lastFiscalYearEnd: DateData?
        let nextFiscalYearEnd: DateData?
        let mostRecentQuarter: DateData?
        let netIncomeToCommon: Int?
        let trailingEps: Double?
        let forwardEps: Double?
        let lastSplitFactor: String?
        let enterpriseToRevenue: Double?
        let enterpriseToEbitda: Double?
        let fiftyTwoWeekChange: Double?
        let sandP52WeekChange: Double?
        let latestShareClass: String?
        let leadInvestor: String?
        
        struct DateData: Codable {
            let raw: Int?
            let fmt: String?
        }
        
        private enum CodingKeys: String, CodingKey {
            case maxAge, priceHint, enterpriseValue, forwardPE, profitMargins, floatShares, sharesOutstanding, sharesShort, sharesShortPriorMonth, sharesShortPreviousMonthDate, dateShortInterest, sharesPercentSharesOut, heldPercentInsiders, heldPercentInstitutions, shortRatio, shortPercentOfFloat, beta, impliedSharesOutstanding, category, bookValue, priceToBook, fundFamily, legalType, lastFiscalYearEnd, nextFiscalYearEnd, mostRecentQuarter, netIncomeToCommon, trailingEps, forwardEps, lastSplitFactor, enterpriseToRevenue, enterpriseToEbitda
            case fiftyTwoWeekChange = "52WeekChange"
            case sandP52WeekChange = "SandP52WeekChange"
            case latestShareClass, leadInvestor
        }
    }
    
    struct SummaryProfile: Codable {
        let address1: String?
        let city: String?
        let state: String?
        let zip: String?
        let country: String?
        let phone: String?
        let website: String?
        let industry: String?
        let industryKey: String?
        let industryDisp: String?
        let sector: String?
        let sectorKey: String?
        let sectorDisp: String?
        let longBusinessSummary: String?
        let companyOfficers: [String]?
        let executiveTeam: [String]?
        let maxAge: Int?
    }
    
    struct NetSharePurchaseActivity: Codable {
        let maxAge: Int?
        let period: String?
        let buyInfoCount: Int?
        let buyInfoShares: Int?
        let sellInfoCount: Int?
        let netInfoCount: Int?
        let netInfoShares: Int?
        let totalInsiderShares: Int?
    }
    
    struct InsiderTransactions: Codable {
        let transactions: [Transaction]?
        let maxAge: Int?
        
        struct Transaction: Codable {
            let maxAge: Int?
            let shares: ValueData?
            let value: ValueData?
            let filerUrl: String?
            let transactionText: String?
            let filerName: String?
            let filerRelation: String?
            let moneyText: String?
            let startDate: DateData?
            let ownership: String?
            
            struct ValueData: Codable {
                let raw: Int?
                let fmt: String?
                let longFmt: String?
            }
            
            struct DateData: Codable {
                let raw: Int?
                let fmt: String?
            }
        }
    }
    
    struct FinancialsTemplate: Codable {
        let code: String?
        let maxAge: Int?
    }
    
    struct QuoteType: Codable {
        let exchange: String?
        let quoteType: String?
        let symbol: String?
        let underlyingSymbol: String?
        let shortName: String?
        let longName: String?
        let firstTradeDateEpochUtc: Int?
        let timeZoneFullName: String?
        let timeZoneShortName: String?
        let uuid: String?
        let messageBoardId: String?
        let gmtOffSetMilliseconds: Int?
        let maxAge: Int?
    }
    
    struct FundOwnership: Codable {
        let maxAge: Int?
        let ownershipList: [Ownership]?
        
        struct Ownership: Codable {
            let maxAge: Int?
            let reportDate: DateData?
            let organization: String?
            let pctHeld: ValueData?
            let position: ValueData?
            let value: ValueData?
            let pctChange: ValueData?
            
            struct DateData: Codable {
                let raw: Int?
                let fmt: String?
            }
            
            struct ValueData: Codable {
                let raw: Double?
                let fmt: String?
                let longFmt: String?
            }
        }
    }
    
    struct SummaryDetail: Codable {
        let maxAge: Int?
        let priceHint: Int?
        let previousClose: Double?
        let open: Double?
        let dayLow: Double?
        let dayHigh: Double?
        let regularMarketPreviousClose: Double?
        let regularMarketOpen: Double?
        let regularMarketDayLow: Double?
        let regularMarketDayHigh: Double?
        let payoutRatio: Int?
        let beta: Double?
        let forwardPE: Double?
        let volume: Int?
        let regularMarketVolume: Int?
        let averageVolume: Int?
        let averageVolume10days: Int?
        let averageDailyVolume10Day: Int?
        let bid: Double?
        let ask: Double?
        let bidSize: Int?
        let askSize: Int?
        let marketCap: Int?
        let fiftyTwoWeekLow: Double?
        let fiftyTwoWeekHigh: Double?
        let priceToSalesTrailing12Months: Double?
        let fiftyDayAverage: Double?
        let twoHundredDayAverage: Double?
        let trailingAnnualDividendRate: Int?
        let trailingAnnualDividendYield: Int?
        let currency: String?
        let fromCurrency: String?
        let toCurrency: String?
        let lastMarket: String?
        let coinMarketCapLink: String?
        let algorithm: String?
        let tradeable: Bool?
    }
    
    struct InsiderHolders: Codable {
        let holders: [Holder]?
        let maxAge: Int?
        
        struct Holder: Codable {
            let maxAge: Int?
            let name: String?
            let relation: String?
            let url: String?
            let transactionDescription: String?
            let latestTransDate: DateData?
            let positionDirect: ValueData?
            let positionDirectDate: DateData?
            
            struct DateData: Codable {
                let raw: Int?
                let fmt: String?
            }
            
            struct ValueData: Codable {
                let raw: Int?
                let fmt: String?
                let longFmt: String?
            }
            
            private enum CodingKeys: String, CodingKey {
                case maxAge, name, relation, url
                case transactionDescription = "transactionDescription"
                case latestTransDate, positionDirect, positionDirectDate
            }
        }
    }
    
    struct Earnings: Codable {
        let maxAge: Int?
        let earningsChart: EarningsChart?
        let financialsChart: FinancialsChart?
        let financialCurrency: String?
        
        struct EarningsChart: Codable {
            let quarterly: [QuarterlyEarnings]?
            let currentQuarterEstimate: Double?
            let currentQuarterEstimateDate: String?
            let currentQuarterEstimateYear: Int?
            let earningsDate: [Int]?
            let isEarningsDateEstimate: Bool?
            
            struct QuarterlyEarnings: Codable {
                let date: String?
                let actual: Double?
                let estimate: Double?
            }
        }
        
        struct FinancialsChart: Codable {
            let yearly: [YearlyFinancials]?
            let quarterly: [QuarterlyFinancials]?
            
            struct YearlyFinancials: Codable {
                let date: Int?
                let revenue: Int?
                let earnings: Int?
            }
            
            struct QuarterlyFinancials: Codable {
                let date: String?
                let revenue: Int?
                let earnings: Int?
            }
        }
    }
    
    struct CalendarEvents: Codable {
        let maxAge: Int?
        let earnings: EarningsData?
        
        struct EarningsData: Codable {
            let earningsDate: [Int]?
            let earningsCallDate: [Int]?
            let isEarningsDateEstimate: Bool?
            let earningsAverage: Double?
            let earningsLow: Double?
            let earningsHigh: Double?
            let revenueAverage: Int?
            let revenueLow: Int?
            let revenueHigh: Int?
        }
    }
    
    struct UpgradeDowngradeHistory: Codable {
        let history: [HistoryItem]?
        let maxAge: Int?
        
        struct HistoryItem: Codable {
            let epochGradeDate: Int?
            let firm: String?
            let toGrade: String?
            let fromGrade: String?
            let action: String?
        }
    }
    
    struct PageViews: Codable {
        let shortTermTrend: String?
        let midTermTrend: String?
        let longTermTrend: String?
        let maxAge: Int?
    }
    
    struct Price: Codable {
        let maxAge: Int?
        let preMarketSource: String?
        let regularMarketChangePercent: Double?
        let regularMarketChange: Double?
        let regularMarketTime: Int?
        let priceHint: Int?
        let regularMarketPrice: Double?
        let regularMarketDayHigh: Double?
        let regularMarketDayLow: Double?
        let regularMarketVolume: Int?
        let averageDailyVolume10Day: Int?
        let averageDailyVolume3Month: Int?
        let regularMarketPreviousClose: Double?
        let regularMarketSource: String?
        let regularMarketOpen: Double?
        let exchange: String?
        let exchangeName: String?
        let exchangeDataDelayedBy: Int?
        let marketState: String?
        let quoteType: String?
        let symbol: String?
        let underlyingSymbol: String?
        let shortName: String?
        let longName: String?
        let currency: String?
        let quoteSourceName: String?
        let currencySymbol: String?
        let fromCurrency: String?
        let toCurrency: String?
        let lastMarket: String?
        let marketCap: Int?
    }
    
    struct FinancialData: Codable {
        let maxAge: Int?
        let currentPrice: Double?
        let targetHighPrice: Double?
        let targetLowPrice: Double?
        let targetMeanPrice: Double?
        let targetMedianPrice: Double?
        let recommendationMean: Double?
        let recommendationKey: String?
        let numberOfAnalystOpinions: Int?
        let totalCash: Int?
        let totalCashPerShare: Double?
        let ebitda: Int?
        let totalDebt: Int?
        let quickRatio: Double?
        let currentRatio: Double?
        let totalRevenue: Int?
        let debtToEquity: Double?
        let revenuePerShare: Double?
        let returnOnAssets: Double?
        let returnOnEquity: Double?
        let grossProfits: Int?
        let freeCashflow: Int?
        let operatingCashflow: Int?
        let revenueGrowth: Double?
        let grossMargins: Double?
        let ebitdaMargins: Double?
        let operatingMargins: Double?
        let profitMargins: Double?
        let financialCurrency: String?
    }
}
