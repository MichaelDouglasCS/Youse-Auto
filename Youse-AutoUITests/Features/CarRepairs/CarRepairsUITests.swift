//
//  CarRepairsUITests.swift
//  Youse-AutoUITests
//
//  Created by Michael Douglas on 10/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CarRepairsUITests: XCTestCase {
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
        
    override func setUp() {
        super.setUp()
        self.continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func testCarRepairsScreenWithMockShouldAppear() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_CAR_REPAIRS_LIST")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        XCTAssert(app.cells["car_repair_cell"].exists, "Should open CarRepairs Screen")
    }
    
    func testCarRepairsScreenWithStubShouldLoad2Cells() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_CAR_REPAIRS_LIST")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        XCTAssertTrue(app.cells.count == 2, "Should load 2 cells")
    }
    
    func testCarRepairsScreenWithoutStubShouldLoadCells() {
        let app = XCUIApplication()
        app.launch()
        
        let predicate = NSPredicate(format: "exists == 1")
        self.expectation(for: predicate,
                         evaluatedWith: app.cells["car_repair_cell"],
                         handler: nil)
        
        self.waitForExpectations(timeout: 30.0) { (_) in
            XCTAssertTrue(app.cells.count > 0, "Should load cells")
        }
    }
    
    func testCarRepairsScreenWithStubShouldAlertAppear() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_NO_CONNECTION")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        XCTAssertTrue(app.alerts.firstMatch.exists, "Should alert appear")
    }
    
    func testCarRepairsScreenWithStubShouldAlertDismiss() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_NO_CONNECTION")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        app.alerts.firstMatch.buttons.firstMatch.tap()
        XCTAssertFalse(app.alerts.firstMatch.exists, "Should alert dismiss")
    }
}
