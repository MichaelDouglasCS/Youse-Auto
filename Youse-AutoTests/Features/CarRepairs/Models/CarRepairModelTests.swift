//
//  CarRepairModelTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Youse_Auto

class CarRepairModelTests: XCTestCase {

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
    
    func testCarRepairParsingShouldExist() {
        let json = self.localJSONFrom(fileName: "carRepair")
        let carRepair = CarRepair(json: json ?? [:])
        XCTAssertNotNil(carRepair, "Car Repair should exist")
    }
    
    func testCarRepairParsingShouldNotExist() {
        let carRepair = CarRepair(json: [:])
        XCTAssertNil(carRepair, "Car Repair should not exist")
    }
    
    func testCarRepairWithValidateParamsShouldSuccess() {
        var json: JSON = ["place_id": "Test",
                          "name": "Test",
                          "vicinity": "Test"]
        XCTAssertNotNil(CarRepair(json: json), "Car Repair should exist")
        
        json = [:]
        json["place_id"] = "Test"
        XCTAssertNil(CarRepair(json: json), "Car Repair should not exist")
        
        json = [:]
        json["name"] = "Test"
        XCTAssertNil(CarRepair(json: json), "Car Repair should not exist")
        
        json = [:]
        json["vicinity"] = "Test"
        XCTAssertNil(CarRepair(json: json), "Car Repair should not exist")
    }
    
    func testCarRepairParsingAllParamsSuccess() {
        let json = self.localJSONFrom(fileName: "carRepair")
        let carRepair = CarRepair(json: json ?? [:])
        
        XCTAssertTrue(carRepair?.id?.isEmpty == false)
        XCTAssertTrue(carRepair?.placeID.isEmpty == false)
        XCTAssertTrue(carRepair?.name.isEmpty == false)
        XCTAssertNotNil(carRepair?.rating)
        XCTAssertNotNil(carRepair?.location)
        XCTAssertTrue(carRepair?.address.isEmpty == false)
        XCTAssertNotNil(carRepair?.isOpenNow)
        XCTAssertNotNil(carRepair?.isOpenFormatted)
        XCTAssertNotNil(carRepair?.image)
    }
}
