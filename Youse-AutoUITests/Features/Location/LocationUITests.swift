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
        app.launchArguments.append("TEST_LOCATION")
        app.launch()
        
        XCTAssert(app.buttons["continue_button"].exists, "Should open Location Screen")
    }
    
    func testLocationScreenShouldDismiss() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_LOCATION")
        app.launch()
        
        app.buttons["continue_button"].tap()
        XCTAssert(!app.buttons["continue_button"].exists, "Should dismiss Location Screen")
    }
    
    func testLocationScreenShouldAlertAppear() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_LOCATION")
        app.launchArguments.append("TEST_LOCATION_ERROR")
        app.launch()
        
        app.buttons["continue_button"].tap()
        XCTAssert(app.alerts.firstMatch.exists, "Should alert appear")
    }
    
    func testLocationScreenShouldAlertDismiss() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_LOCATION")
        app.launchArguments.append("TEST_LOCATION_ERROR")
        app.launch()
        
        app.buttons["continue_button"].tap()
        XCTAssert(app.alerts.firstMatch.exists, "Should alert appear")
        
        app.alerts.firstMatch.buttons.firstMatch.tap()
        XCTAssert(!app.alerts.firstMatch.exists, "Should alert disappear")
    }
}
