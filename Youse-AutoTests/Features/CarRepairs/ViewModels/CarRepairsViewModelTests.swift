//
//  CarRepairsViewModelTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CarRepairsViewModelTests: XCTestCase {
    
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
    
    func testCarRepairsViewModelShouldRefreshBeSuccess() {
        let expectation = self.expectation(description: #function)
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        viewModel.loadData(type: .refresh) { (error) in
            XCTAssertNil(error, "Error should nil")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsViewModelShouldRefreshBeFailed() {
        let expectation = self.expectation(description: #function)
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        let stubService = StubService()
        stubService.addStub(for: .noConnection)
        
        viewModel.loadData(type: .refresh) { (error) in
            XCTAssertNotNil(error, "Error should not nil")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsViewModelShouldHasNextPageTrue() {
        let expectation = self.expectation(description: #function)
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        viewModel.loadData(type: .refresh) { (_) in
            XCTAssertTrue(viewModel.hasNextPage, "Should hasNextPage true")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsViewModelShouldHasNextPageFalse() {
        let expectation = self.expectation(description: #function)
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        let stubService = StubService()
        stubService.addStub(for: .noConnection)
        
        viewModel.loadData(type: .refresh) { (_) in
            XCTAssertFalse(viewModel.hasNextPage, "Should hasNextPage false")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsViewModelShouldReturnPlaceID() {
        let expectation = self.expectation(description: #function)
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        viewModel.loadData(type: .refresh) { (_) in
            XCTAssertTrue(!viewModel.placeID(at: 0).isEmpty, "Should return placeID")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsViewModelShouldNumberOfRowsEqualZero() {
        let expectation = self.expectation(description: #function)
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        let stubService = StubService()
        stubService.addStub(for: .noConnection)
        
        viewModel.loadData(type: .bringMore) { (_) in
            XCTAssertTrue(viewModel.numberOfRows() == 0, "Should be equal 0")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsViewModelShouldNumberOfRowsEqual4() {
        let expectation = self.expectation(description: #function)
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        viewModel.loadData(type: .refresh) { (_) in
            viewModel.loadData(type: .bringMore, completion: { (_) in
                XCTAssertTrue(viewModel.numberOfRows() == 4, "Should be equal to 4")
                expectation.fulfill()
            })
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairsViewModelShouldIsLoadingFalse() {
        let expectation = self.expectation(description: #function)
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        viewModel.loadData(type: .refresh) { (_) in
            XCTAssertFalse(viewModel.isLoading, "Should be false")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
}
