//
//  PhotoModelTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class PhotoModelTests: XCTestCase {
    
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
    
    func testPhotoParsingShouldExist() {
        let json = self.localJSONFrom(fileName: "photo")
        let photo = Photo(json: json ?? [:])
        
        XCTAssertNotNil(photo, "Photo should exist")
    }
    
    func testPhotoParsingShouldNotExist() {
        let photo = Photo(json: [:])
        XCTAssertNil(photo, "Photo should not exist")
    }
    
    func testPhotoWithReferenceParamShouldBeSuccess() {
        XCTAssertNotNil(Photo(json: ["photo_reference": "Test"]), "Photo should exist")
    }
    
    func testCarRepairParsingAllParamsShouldBeSuccess() {
        let json = self.localJSONFrom(fileName: "photo")
        let photo = Photo(json: json ?? [:])
        
        XCTAssertTrue(photo?.id?.isEmpty == false, "ID should exists")
        XCTAssertNotNil(photo?.width, "Width should exists")
        XCTAssertNotNil(photo?.height, "Height should exists")
        XCTAssertNotNil(photo?.url, "URL should exists")
    }
}
