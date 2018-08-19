//
//  CarRepairDetailsViewModelTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 19/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CarRepairDetailsViewModelTests: XCTestCase {
    
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
    
    func testCarRepairDetailsViewModelShouldLoadDataBeSuccess() {
        let expectation = self.expectation(description: #function)
        let json = self.localJSONFrom(fileName: "carRepairDetails")
        let carRepairDetails = CarRepairDetails(json: json ?? [:])
        let viewModel = CarRepairDetailsViewModel(provider: CarRepairDetailsProvider(),
                                                  placeID: carRepairDetails?.placeID ?? "")
        let stubService = StubService()
        stubService.addStub(for: .carRepairDetails)
        
        viewModel.loadData { (error) in
            XCTAssertNil(error, "Should error not exists")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testCarRepairDetailsViewModelShouldLoadDataBeFailed() {
        let expectation = self.expectation(description: #function)
        let json = self.localJSONFrom(fileName: "carRepairDetails")
        let carRepairDetails = CarRepairDetails(json: json ?? [:])
        let viewModel = CarRepairDetailsViewModel(provider: CarRepairDetailsProvider(),
                                                  placeID: carRepairDetails?.placeID ?? "")
        let stubService = StubService()
        stubService.addStub(for: .noConnection)
        
        viewModel.loadData { (error) in
            XCTAssertNotNil(error, "Should error exists")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
}
