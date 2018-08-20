//
//  CarRepairDetailsUITests.swift
//  Youse-AutoUITests
//
//  Created by Michael Douglas on 10/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CarRepairDetailsUITests: XCTestCase {
    
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
    
    func testCarRepairDetailsScreenWithMockShouldAppear() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_CAR_REPAIRS_LIST")
        app.launchArguments.append("TEST_CAR_REPAIR_DETAILS")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        app.cells["car_repair_cell"].firstMatch.tap()
        
        XCTAssertTrue(app.cells["details_cell"].exists, "Shoud Car Repair Details Screen appear")
    }
    
    func testCarRepairDetailsScreenWithoutMockShouldAppear() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        let predicate = NSPredicate(format: "exists == 1")
        let carRepairCell = self.expectation(for: predicate,
                                             evaluatedWith: app.cells["car_repair_cell"],
                                             handler: nil)
        
        let detailsCell = self.expectation(for: predicate,
                                           evaluatedWith: app.cells["details_cell"],
                                           handler: nil)
        
        self.wait(for: [carRepairCell], timeout: 30.0)
        app.cells["car_repair_cell"].firstMatch.tap()
        
        self.wait(for: [detailsCell], timeout: 30.0)
        XCTAssertTrue(app.cells["details_cell"].exists, "Shoud Car Repair Details Screen appear")
    }
    
    func testCarRepairDetailsScreenWithMockShouldPop() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_CAR_REPAIRS_LIST")
        app.launchArguments.append("TEST_CAR_REPAIR_DETAILS")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        app.cells["car_repair_cell"].firstMatch.tap()
        XCTAssertTrue(app.cells["details_cell"].exists, "Shoud Car Repair Details Screen appear")
        
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(app.cells["car_repair_cell"].exists, "Shoud Car Repair Details Screen Pop to Car Repairs Screen")
    }
    
    func testCarRepairDetailsScreenWithMockShouldDirectionsPopupAppear() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_CAR_REPAIRS_LIST")
        app.launchArguments.append("TEST_CAR_REPAIR_DETAILS")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        app.cells["car_repair_cell"].firstMatch.tap()
        XCTAssertTrue(app.cells["details_cell"].exists, "Shoud Car Repair Details Screen appear")
        
        app.cells["details_cell"].firstMatch.buttons["directions_button"].tap()
        XCTAssertTrue(app.buttons["Apple Maps"].exists, "Shoud appear Apple Maps Option")
        XCTAssertTrue(app.buttons["Google Maps"].exists, "Shoud appear Google Maps Option")
    }
    
    func testCarRepairDetailsScreenWithMockShould3ContactInfoCellsExists() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_CAR_REPAIRS_LIST")
        app.launchArguments.append("TEST_CAR_REPAIR_DETAILS")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        app.cells["car_repair_cell"].firstMatch.tap()
        XCTAssertTrue(app.cells["details_cell"].exists, "Shoud Car Repair Details Screen appear")
        
        app.tables.firstMatch.swipeUp()
        
        let contactInfoCells = app.cells.containing(.cell, identifier: "contact_info_cell")
        XCTAssertTrue(contactInfoCells.count == 3, "Should 3 Contact Info Cells exists")
    }
    
    func testCarRepairDetailsScreenWithMockShould5ReviewsExists() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST_CAR_REPAIRS_LIST")
        app.launchArguments.append("TEST_CAR_REPAIR_DETAILS")
        app.launchArguments.append("TEST_LOCATION_SUCCESS")
        app.launch()
        
        app.cells["car_repair_cell"].firstMatch.tap()
        XCTAssertTrue(app.cells["details_cell"].exists, "Shoud Car Repair Details Screen appear")
        
        app.tables.firstMatch.swipeUp()
        
        let reviewCells = app.cells.containing(.cell, identifier: "review_cell")
        XCTAssertTrue(reviewCells.count == 5, "Should 5 Review Cells exists")
    }
}
