//
//  LocationUITests.swift
//  Youse-AutoUITests
//
//  Created by Michael Douglas on 10/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class LocationUITests: XCTestCase {
    
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
    
    func testLocationScreenShouldAppear() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_LOCATION_ERROR")
        app.launch()
        
        XCTAssertTrue(app.buttons["continue_button"].exists, "Should open Location Screen")
    }
    
    func testLocationScreenShouldDismiss() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_LOCATION_ERROR")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        app.buttons["continue_button"].tap()
        XCTAssertFalse(app.buttons["continue_button"].exists, "Should dismiss Location Screen")
    }
    
    func testLocationScreenShouldAlertAppear() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_LOCATION_ERROR")
        app.launch()
        
        app.buttons["continue_button"].tap()
        XCTAssertTrue(app.alerts.firstMatch.exists, "Should alert appear")
    }
    
    func testLocationScreenShouldAlertDismiss() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_LOCATION_ERROR")
        app.launch()
        
        app.buttons["continue_button"].tap()
        XCTAssertTrue(app.alerts.firstMatch.exists, "Should alert appear")
        
        app.alerts.firstMatch.buttons.firstMatch.tap()
        XCTAssertFalse(app.alerts.firstMatch.exists, "Should alert disappear")
    }
}
