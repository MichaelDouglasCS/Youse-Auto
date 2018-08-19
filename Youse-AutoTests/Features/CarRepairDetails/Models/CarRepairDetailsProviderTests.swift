//
//  CarRepairDetailsProviderTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CarRepairDetailsProviderTests: XCTestCase {
    
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
    
    func testCarRepairDetailsProviderWithValidPlaceIDShoulBeSuccess() {
        let expectation = self.expectation(description: #function)
        let location = self.userLocationYouse
        let carRepairsProvider = CarRepairsProvider()
        let provider = CarRepairDetailsProvider()
        
        carRepairsProvider.carRepairs(by: location) { (carRepairs, _, _) in
            if let placeID = carRepairs.first?.placeID {
                provider.carRepairDetails(byPlaceID: placeID, completion: { (_, error) in
                    XCTAssertNil(error, "Should be success")
                    expectation.fulfill()
                })
            } else {
                XCTAssertTrue(false, "Place ID should exists")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairDetailsProviderWithValidPlaceIDShoulReturnResults() {
        let expectation = self.expectation(description: #function)
        let location = self.userLocationYouse
        let carRepairsProvider = CarRepairsProvider()
        let provider = CarRepairDetailsProvider()
        
        carRepairsProvider.carRepairs(by: location) { (carRepairs, _, _) in
            if let placeID = carRepairs.first?.placeID {
                provider.carRepairDetails(byPlaceID: placeID, completion: { (details, _) in
                    XCTAssertNotNil(details, "Details should exists")
                    expectation.fulfill()
                })
            } else {
                XCTAssertTrue(false, "Place ID should exists")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairDetailsProviderWithValidPlaceIDShoulBeFailed() {
        let expectation = self.expectation(description: #function)
        let provider = CarRepairDetailsProvider()
        let stubService = StubService()
        stubService.addStub(for: .noConnection)
        
        provider.carRepairDetails(byPlaceID: "Test", completion: { (_, error) in
            XCTAssertNotNil(error, "Should be failed")
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: self.timeout)
    }
}
