//
//  ModularSwiftUIAppUITests.swift
//  ModularSwiftUIAppUITests
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import XCTest

final class ModularSwiftUIAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing", "-disable-animations"]
        app.launchEnvironment = [
            "UITEST_DISABLE_ANIMATIONS": "1",
            "NETWORK_RESPONSES": "test_data",
            "MOCK_MARKET_RESPONSE": TestData.marketSummary,
            "MOCK_STOCK_RESPONSE": TestData.stockDetail,
            "NETWORK_DELAY": "1" // Reduced delay for tests
        ]
    }

    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testOnboardingScreenComponents() throws {
        app.launch()
        
        // Verify all main components exist
        XCTAssert(app.waitForElementToAppear(app.staticTexts["Stock Market Overview"]))
        XCTAssert(app.waitForElementToAppear(app.textFields["Search Stocks"]))
        XCTAssert(app.waitForElementToAppear(app.buttons["Continue"]))
        
        // Check for either loading indicator or content
        let loader = app.activityIndicators.firstMatch
        let firstStock = app.buttons["Apple Inc."] // Match the actual data
        
        if app.waitForElementToAppear(loader, timeout: 2) {
            // If loader appears, wait for it to disappear and content to appear
            XCTAssert(app.waitForElementToDisappear(loader, timeout: 5))
            XCTAssert(app.waitForElementToAppear(firstStock))
        } else {
            // If no loader, content should be visible
            XCTAssert(app.waitForElementToAppear(firstStock))
        }
    }
    
    func testStockListLoading() throws {
        app.launch()
        
        // Wait for data to load
        let firstStock = app.buttons["AAPL"]
        XCTAssert(app.waitForElementToAppear(firstStock))
        
        // Verify list items
        XCTAssert(app.staticTexts["Price: $150.00"].exists)
        
        // Verify change percentage
        let changeText = app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'Change:'")).firstMatch
        XCTAssert(changeText.exists)
    }
    
    func testStockSearchFunctionality() throws {
        app.launch()
        
        let searchField = app.textFields["Search Stocks"]
        XCTAssert(app.waitForElementToAppear(searchField))
        
        // Test search
        searchField.tap()
        searchField.typeText("AAPL")
        
        // Verify filtering
        XCTAssert(app.waitForElementToAppear(app.buttons["AAPL"]))
        XCTAssertFalse(app.buttons["MSFT"].exists)
        
        // Clear search
        if app.waitForElementToAppear(searchField.buttons["Clear text"], timeout: 1) {
            searchField.buttons["Clear text"].tap()
        } else {
            searchField.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: 4))
        }
        
        XCTAssert(app.waitForElementToAppear(app.buttons["AAPL"]))
        XCTAssert(app.waitForElementToAppear(app.buttons["MSFT"]))
    }
    
    func testStockDetailNavigation() throws {
        app.launch()
        
        // Wait for data and tap first item
        let firstStock = app.buttons["AAPL"]
        XCTAssert(app.waitForElementToAppear(firstStock))
        firstStock.tap()
        
        // Verify detail screen
        XCTAssert(app.waitForElementToAppear(app.navigationBars["AAPL"]))
        XCTAssert(app.staticTexts["Apple Inc."].exists)
        XCTAssert(app.staticTexts["$150.00"].exists)
    }
    
    func testContinueButtonAction() throws {
        app.launch()
        
        let continueButton = app.buttons["Continue"]
        XCTAssert(app.waitForElementToAppear(continueButton))
        continueButton.tap()
        
        // Add verification for navigation if implemented
    }
    
    func testLoaderVisibilityDuringNetworkCalls() throws {
        app.launchEnvironment["NETWORK_DELAY"] = "2"
        app.launch()
        
        // Verify loader appears immediately
        let loader = app.activityIndicators.firstMatch
        XCTAssert(app.waitForElementToAppear(loader, timeout: 1))
        
        // Wait for loader to disappear
        XCTAssert(app.waitForElementToDisappear(loader, timeout: 5))
    }
    
    func testErrorHandling() throws {
        app.launchEnvironment["FORCE_NETWORK_ERROR"] = "1"
        app.launch()
        
        // Verify error state is shown
        let errorText = app.staticTexts["Failed to load data"]
        XCTAssert(app.waitForElementToAppear(errorText))
        
        // Verify retry button
        let retryButton = app.buttons["Retry"]
        XCTAssert(app.waitForElementToAppear(retryButton))
    }
}

extension ModularSwiftUIAppUITests {
    enum TestData {
        static let marketSummary = """
        {
            "marketSummaryResponse": {
                "result": [
                    {
                        "shortName": "Apple Inc.",
                        "symbol": "AAPL",
                        "regularMarketPrice": {"raw": 150.00, "fmt": "150.00"},
                        "regularMarketChangePercent": {"raw": 0.005, "fmt": "0.50%"}
                    },
                    {
                        "shortName": "Microsoft Corp.",
                        "symbol": "MSFT",
                        "regularMarketPrice": {"raw": 250.00, "fmt": "250.00"},
                        "regularMarketChangePercent": {"raw": -0.003, "fmt": "-0.30%"}
                    }
                ]
            }
        }
        """
        
        static let stockDetail = """
        {
            "symbol": "AAPL",
            "quoteType": {
                "longName": "Apple Inc.",
                "shortName": "Apple"
            },
            "price": {
                "regularMarketPrice": 150.00,
                "regularMarketChange": 2.00,
                "regularMarketChangePercent": 0.013,
                "regularMarketPreviousClose": 148.00
            },
            "summaryDetail": {
                "fiftyTwoWeekLow": 120.00,
                "fiftyTwoWeekHigh": 180.00,
                "regularMarketVolume": 12345678
            },
            "summaryProfile": {
                "industry": "Consumer Electronics"
            }
        }
        """
    }
}
