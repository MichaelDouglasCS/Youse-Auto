//
//  NetworkTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 11/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
import CoreLocation
import SwiftyJSON
@testable import Youse_Auto

class NetworkTests: XCTestCase {
    
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
    
    func testListNearbyWithLocationShouldSuccess() {
        let expectation = self.expectation(description: #function)
        let location = CLLocation(latitude: 37.3330499, longitude: -122.0110933)
        
        NetworkRequest.CarRepairShop.listNearby(to: location).execute { (_, response) in
            XCTAssertTrue(response.isSuccess, "Response should be success")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0)
    }
    
    func testListNearbyWithLocationShouldJSONNotEmpty() {
        let expectation = self.expectation(description: #function)
        let location = CLLocation(latitude: 37.3330499, longitude: -122.0110933)
        
        NetworkRequest.CarRepairShop.listNearby(to: location).execute { (json, _) in
            XCTAssertFalse(json.isEmpty, "JSON should be not empty")
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0)
    }
    
    func testListNearbyWithNextPageTokenShouldJSONNotEmpty() {
        let expectation = self.expectation(description: #function)
        let location = CLLocation(latitude: 37.3330499, longitude: -122.0110933)
        
        NetworkRequest.CarRepairShop.listNearby(to: location).execute { (json, _) in
            let pageNextToken = json["next_page_token"].string
            XCTAssertNotNil(pageNextToken, "Page Next Token should be not nil")
            
            NetworkRequest.CarRepairShop.listNearby(to: location,
                                                    withNext: pageNextToken).execute { (json, _) in
                XCTAssertFalse(json.isEmpty, "JSON should be not empty")
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 20.0)
    }
}
