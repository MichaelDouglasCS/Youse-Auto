//
//  CarRepairsProviderTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CarRepairsProviderTests: XCTestCase {

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
    
    func testCarRepairsWithValidLocationShouldBeSuccess() {
        let expectation = self.expectation(description: #function)
        let location = self.userLocationYouse
        let provider = CarRepairsProvider()
        
        provider.carRepairs(by: location) { (_, _, error) in
            XCTAssertNil(error, "Should be success")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsWithValidLocationShouldReturnResults() {
        let expectation = self.expectation(description: #function)
        let location = self.userLocationYouse
        let provider = CarRepairsProvider()
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        provider.carRepairs(by: location) { (carRepairs, _, _) in
            XCTAssertFalse(carRepairs.isEmpty, "Results should exists")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsWithValidLocationShouldReturnNextPage() {
        let expectation = self.expectation(description: #function)
        let location = self.userLocationYouse
        let provider = CarRepairsProvider()
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        provider.carRepairs(by: location) { (_, nextPage, _) in
            XCTAssertTrue(nextPage?.isEmpty == false, "Next Page should exist")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsWithValidLocationShouldBeFailed() {
        let expectation = self.expectation(description: #function)
        let location = self.userLocationYouse
        let provider = CarRepairsProvider()
        let stubService = StubService()
        stubService.addStub(for: .noConnection)
        
        provider.carRepairs(by: location) { (_, _, error) in
            XCTAssertNotNil(error, "Should be failed")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
}
