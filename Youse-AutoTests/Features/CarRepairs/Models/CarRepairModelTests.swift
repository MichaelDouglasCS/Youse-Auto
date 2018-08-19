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
    
    func testCarRepairParsingShouldExists() {
        let json = self.localJSONFrom(fileName: "carRepair")
        let carRepair = CarRepair(json: json ?? [:])
        XCTAssertNotNil(carRepair, "Car Repair should exists")
    }
    
    func testCarRepairParsingShouldNotExists() {
        let carRepair = CarRepair(json: [:])
        XCTAssertNil(carRepair, "Car Repair should not exists")
    }
    
    func testCarRepairWithValidateParamsShouldBeSuccess() {
        var json: JSON = ["place_id": "Test",
                          "name": "Test",
                          "vicinity": "Test"]
        XCTAssertNotNil(CarRepair(json: json), "Car Repair should exists")
        
        json = [:]
        json["place_id"] = "Test"
        XCTAssertNil(CarRepair(json: json), "Car Repair should not exists")
        
        json = [:]
        json["name"] = "Test"
        XCTAssertNil(CarRepair(json: json), "Car Repair should not exists")
        
        json = [:]
        json["vicinity"] = "Test"
        XCTAssertNil(CarRepair(json: json), "Car Repair should not exists")
    }
    
    func testCarRepairParsingAllParamsShouldBeSuccess() {
        let json = self.localJSONFrom(fileName: "carRepair")
        let carRepair = CarRepair(json: json ?? [:])
        
        XCTAssertTrue(carRepair?.id?.isEmpty == false, "ID should exists")
        XCTAssertTrue(carRepair?.placeID.isEmpty == false, "PlaceID should exists")
        XCTAssertTrue(carRepair?.name.isEmpty == false, "Name should exists")
        XCTAssertNotNil(carRepair?.rating, "Rating should exists")
        XCTAssertNotNil(carRepair?.location, "Location should exists")
        XCTAssertTrue(carRepair?.address.isEmpty == false, "Address should exists")
        XCTAssertNotNil(carRepair?.isOpenNow, "isOpenNow should exists")
        XCTAssertNotNil(carRepair?.isOpenFormatted, "isOpenFormatted should exists")
        XCTAssertNotNil(carRepair?.image, "Image should exists")
    }
}
