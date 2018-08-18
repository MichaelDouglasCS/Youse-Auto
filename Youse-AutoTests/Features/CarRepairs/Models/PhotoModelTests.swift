//
//  PhotoModelTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
import SwiftyJSON
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
    
    func testPhotoWithReferenceParamShouldSuccess() {
        XCTAssertNotNil(Photo(json: ["photo_reference": "Test"]), "Photo should exist")
    }
    
    func testCarRepairParsingAllParamsSuccess() {
        let json = self.localJSONFrom(fileName: "photo")
        let photo = Photo(json: json ?? [:])
        
        XCTAssertTrue(photo?.id?.isEmpty == false)
        XCTAssertNotNil(photo?.width)
        XCTAssertNotNil(photo?.height)
        XCTAssertNotNil(photo?.url)
    }
}
