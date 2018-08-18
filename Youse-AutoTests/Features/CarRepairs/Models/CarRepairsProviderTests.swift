//
//  CarRepairsProviderTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
import CoreLocation
import SwiftyJSON
import OHHTTPStubs
@testable import Youse_Auto

class CarRepairsProviderTests: XCTestCase {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var locationValid = CLLocation(latitude: -23.5941355, longitude: -46.6802735)
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        StubService.removeAllStubs()
        super.tearDown()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func testCarRepairsWithValidLocationShouldSuccess() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        let provider = CarRepairsProvider()
        
        provider.carRepairs(by: location) { (_, _, error) in
            XCTAssertNil(error, "Should success")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testCarRepairsWithValidLocationShouldReturnResults() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        let provider = CarRepairsProvider()
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        provider.carRepairs(by: location) { (carRepairs, _, _) in
            XCTAssertFalse(carRepairs.isEmpty, "Results should exists")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testCarRepairsWithValidLocationShouldReturnNextPage() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        let provider = CarRepairsProvider()
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        provider.carRepairs(by: location) { (_, nextPage, _) in
            XCTAssertTrue(nextPage?.isEmpty == false, "Next Page should exist")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testCarRepairsWithValidLocationShouldFailed() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        let provider = CarRepairsProvider()
        let stubService = StubService()
        stubService.addStub(for: .noConnection)
        
        provider.carRepairs(by: location) { (_, _, error) in
            XCTAssertNotNil(error, "Should failed")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 30.0)
    }
}
