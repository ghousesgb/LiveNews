//
//  LiveNewsUITests.swift
//  LiveNewsUITests
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import XCTest
@testable import LiveNews

class LiveNewsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        var timeToDelay = 15.0
        repeat {
            let delay = min(13.0, timeToDelay)
            timeToDelay -= delay
            let date = Date().addingTimeInterval(delay)
            let predicate = NSPredicate(format: "now() > %@", argumentArray: [date])
            self.expectation(for: predicate, evaluatedWith: [], handler: nil)
            self.waitForExpectations(timeout: 14.0, handler: nil)
        } while timeToDelay > 0
        
        let tableheadlinglabelStaticText = app.staticTexts["tableHeadlingLabel"].label
        XCTAssert(tableheadlinglabelStaticText == "H E A D L I N E S", "Table Heading check PASSED.")
        
        app.terminate()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
