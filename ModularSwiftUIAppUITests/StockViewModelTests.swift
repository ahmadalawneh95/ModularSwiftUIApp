//
//  StockViewModelTests.swift
//  ModularSwiftUIApp
//
//  Created by Ahmad Alawneh on 29/03/2025.
//

import XCTest
import RxSwift
@testable import NetworkingModule
@testable import OnboardingModule

class StockViewModelTests: XCTestCase {
    
    var viewModel: StockViewModel!
    var disposeBag: DisposeBag!
    var loaderManager: LoaderManager!
    
    override func setUp() {
        super.setUp()
        
        // Configure mock URLSession
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        // Swizzle URLSession.shared to use our mock configuration
        URLSession.swizzleSharedSession(configuration: config)
        
        loaderManager = LoaderManager()
        viewModel = StockViewModel()
        viewModel.loaderManager = loaderManager
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        // Restore original URLSession.shared
        URLSession.restoreSharedSession()
        
        viewModel = nil
        disposeBag = nil
        loaderManager = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }
    
    func testGetMarketSummary_Success() {
        // Given
        let expectedResponse = """
        {
            "marketSummaryResponse": {
                "result": [
                    {
                        "symbol": "AAPL",
                        "shortName": "Apple Inc.",
                        "regularMarketPrice": {"raw": 170.0, "fmt": "170.00"},
                        "regularMarketChangePercent": {"raw": 1.5, "fmt": "1.50%"}
                    }
                ]
            }
        }
        """
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, expectedResponse.data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "Market summary loaded")
        
        // When
        viewModel.getMarketSummary()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.loaderManager.isLoading)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                XCTAssertFalse(self.loaderManager.isLoading)
                XCTAssertNotNil(self.viewModel.marketSummary)
                XCTAssertEqual(self.viewModel.marketSummary?.marketSummaryResponse?.result?.first?.symbol, "AAPL")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetStocks_Success() {
        // Given
        let expectedResponse = """
        {
            "symbol": "AAPL",
            "price": {
                "regularMarketPrice": 170.0,
                "regularMarketChangePercent": 1.5
            }
        }
        """
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, expectedResponse.data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "Stock detail loaded")
        
        // When
        viewModel.getStocks(symbol: "AAPL") { result in
            // Then
            switch result {
            case .success(let stock):
                XCTAssertEqual(stock.symbol, "AAPL")
                XCTAssertEqual(self.viewModel.stockDetail?.symbol, "AAPL")
            case .failure(let error):
                XCTFail("Unexpected error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        XCTAssertTrue(loaderManager.isLoading)
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(loaderManager.isLoading)
    }
    
    func testLoaderManagerIntegration() {
        // Given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, Data())
        }
        
        let expectation = XCTestExpectation(description: "Loader test completed")
        
        // When
        viewModel.getMarketSummary()
        
        // Then
        XCTAssertTrue(loaderManager.isLoading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(self.loaderManager.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("No request handler set")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        // Required to implement
    }
}
