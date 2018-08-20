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
    
    func testCarRepairsScreenShouldAppear() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_CAR_REPAIRS_LIST")
        app.launch()
        
        XCTAssert(app.cells["car_repair_cell"].exists, "Should open CarRepairs Screen")
    }
}
