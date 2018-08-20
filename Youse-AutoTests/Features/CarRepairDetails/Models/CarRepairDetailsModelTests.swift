//
//  CarRepairDetailsModelTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Youse_Auto

class CarRepairDetailsModelTests: XCTestCase {
    
    //*************************************************
    // MARK: - Public Methods
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
    
    func testCarRepairDetailsParsingShouldExists() {
        let json = self.localJSONFrom(fileName: "carRepairDetails")
        let carRepairDetails = CarRepairDetails(json: json?["result"] ?? [:])
        XCTAssertNotNil(carRepairDetails, "Car Repair Details should exists")
    }
    
    func testCarRepairDetailsParsingShouldNotExists() {
        let carRepairDetails = CarRepairDetails(json: [:])
        XCTAssertNil(carRepairDetails, "Car Repair Details should not exists")
    }
    
    func testCarRepairDetailsWithValidateParamsShouldBeSuccess() {
        var json: JSON = ["place_id": "Test",
                          "name": "Test",
                          "vicinity": "Test"]
        XCTAssertNotNil(CarRepairDetails(json: json), "Car Repair Details should exists")
        
        json = [:]
        json["place_id"] = "Test"
        XCTAssertNil(CarRepairDetails(json: json), "Car Repair Details should not exists")
        
        json = [:]
        json["name"] = "Test"
        XCTAssertNil(CarRepairDetails(json: json), "Car Repair Details should not exists")
        
        json = [:]
        json["vicinity"] = "Test"
        XCTAssertNil(CarRepairDetails(json: json), "Car Repair Details should not exists")
    }
    
    func testCarRepairParsingAllParamsShouldBeSuccess() {
        let json = self.localJSONFrom(fileName: "carRepairDetails")
        let carRepairDetails = CarRepairDetails(json: json?["result"] ?? [:])
        
        XCTAssertTrue(carRepairDetails?.id?.isEmpty == false, "ID should exists")
        XCTAssertTrue(carRepairDetails?.placeID.isEmpty == false, "PlaceID should exists")
        XCTAssertTrue(carRepairDetails?.name.isEmpty == false, "Name should exists")
        XCTAssertNotNil(carRepairDetails?.rating, "Rating should exists")
        XCTAssertNotNil(carRepairDetails?.location, "Location should exists")
        XCTAssertTrue(carRepairDetails?.address.isEmpty == false, "Address should exists")
        XCTAssertNotNil(carRepairDetails?.isOpenNow, "isOpenNow should exists")
        XCTAssertNotNil(carRepairDetails?.isOpenFormatted, "isOpenFormatted should exists")
        XCTAssertNotNil(carRepairDetails?.image, "Image should exists")
        XCTAssertNotNil(carRepairDetails?.addressFormatted, "Address Formatted should exists")
        XCTAssertNotNil(carRepairDetails?.phoneFormatted, "Phone Formatted should exists")
        XCTAssertNotNil(carRepairDetails?.internationalPhone, "International Phone should exists")
        XCTAssertNotNil(carRepairDetails?.openingHours, "Address Opening Hours should exists")
        XCTAssertNotNil(carRepairDetails?.images, "Images should exists")
        XCTAssertNotNil(carRepairDetails?.reviews, "Reviews should exists")
    }
    
    func testCarRepairDetailsParsingReviewsShouldBeSorted() {
        let json = self.localJSONFrom(fileName: "carRepairDetails")
        let carRepairDetails = CarRepairDetails(json: json ?? [:])
        
        if let reviewsJSON = json?["reviews"].array {
            let reviews = reviewsJSON.compactMap { Review(json: $0) }
            let sorted = reviews.sorted(by: { $0.time ?? 0 > $1.time ?? 0 })
            let carRepairReviews = carRepairDetails?.reviews ?? []
            
            for (index, review) in carRepairReviews.enumerated() {
                XCTAssertEqual(review.text, sorted[index].text, "Should be sorted")
            }
        }
    }
}
