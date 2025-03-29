//
//  ModularSwiftUIAppUITestsLaunchTests.swift
//  ModularSwiftUIAppUITests
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import XCTest

final class ModularSwiftUIAppUITestsLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchPerformance() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-ui-testing", "-disable-animations"]
        app.launchEnvironment = ["UITEST_DISABLE_ANIMATIONS": "1"]
        
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            app.launch()
        }
    }
    
    func testLaunchScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Take screenshot
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        // Verify either the loading indicator OR the main content appears
        let activityIndicator = app.activityIndicators.firstMatch
        let mainTitle = app.staticTexts["Stock Market Overview"]
        
        // Wait for either the loader or the main content to appear
        let exists = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == true"),
            object: mainTitle
        )
        
        let result = XCTWaiter.wait(for: [exists], timeout: 10)
        if result != .completed {
            // If main title didn't appear, check for loader
            XCTAssertTrue(activityIndicator.exists, "Neither loading indicator nor main content appeared")
        }
    }
}

extension XCUIApplication {
    func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 10) -> Bool {
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == true"),
            object: element
        )
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
    
    func waitForElementToDisappear(_ element: XCUIElement, timeout: TimeInterval = 10) -> Bool {
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: element
        )
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
}
