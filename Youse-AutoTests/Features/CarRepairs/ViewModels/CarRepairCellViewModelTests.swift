//
//  CarRepairCellViewModelTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CarRepairCellViewModelTests: XCTestCase {
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func testCarRepairsCellViewModelParamsShouldExists() {
        let expectation = self.expectation(description: #function)
        let json = self.localJSONFrom(fileName: "carRepair")
        
        LocationService.shared.getLocation(success: { (_) in
            if let carRepair = CarRepair(json: json ?? [:]) {
                let viewModel = CarRepairCellViewModel(carRepair: carRepair)
                
                XCTAssertNotNil(viewModel.placeID, "Place ID should not nil")
                XCTAssertNotNil(viewModel.imageURL, "Image URL should not nil")
                XCTAssertNotNil(viewModel.name, "Name should not nil")
                XCTAssertNotNil(viewModel.rating, "Rating should not nil")
                XCTAssertNotNil(viewModel.address, "Address should not nil")
                XCTAssertNotNil(viewModel.distance, "Distance should not nil")
                XCTAssertNotNil(viewModel.availability, "Availability should not nil")
                expectation.fulfill()
            } else {
                XCTAssertTrue(false, "Car Repair should exists")
                expectation.fulfill()
            }
        }) { (error) in
            XCTAssertTrue(false, "Location should exist. Error: \(error?.localized ?? "")")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsCellViewModelDistanceShouldBeEqual() {
        let expectation = self.expectation(description: #function)
        let json = self.localJSONFrom(fileName: "carRepair")
        
        LocationService.shared.getLocation(success: { (_) in
            if let carRepair = CarRepair(json: json ?? [:]),
                let placeLocation = carRepair.location {
                let viewModel = CarRepairCellViewModel(carRepair: carRepair)
                let userLocation = self.userLocationYouse
                let distance = userLocation.distance(from: placeLocation).kilometers
                
                XCTAssertEqual(viewModel.distance, distance, "Distance should be equal")
                expectation.fulfill()
            } else {
                XCTAssertTrue(false, "Car Repair should exist")
                expectation.fulfill()
            }
        }) { (error) in
            XCTAssertTrue(false, "Location should exist. Error: \(error?.localized ?? "")")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
}
