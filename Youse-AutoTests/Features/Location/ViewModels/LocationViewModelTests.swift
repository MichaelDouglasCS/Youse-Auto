//
//  LocationViewModelTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 20/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class LocationViewModelTests: XCTestCase {
    
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
    
    func testLocationViewModelShouldGetLocation() {
        let viewModel = LocationViewModel()
        
        viewModel.getLocation { (location) in
            XCTAssertNotNil(location, "Location should exists")
        }
    }
}
