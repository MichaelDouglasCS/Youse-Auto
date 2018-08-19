//
//  ReviewModelTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 19/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Youse_Auto

class ReviewModelTests: XCTestCase {
    
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
    
    func testReviewParsingShouldExists() {
        let json = self.localJSONFrom(fileName: "review")
        let review = Review(json: json ?? [:])
        XCTAssertNotNil(review, "Review should exists")
    }
    
    func testReviewParsingShouldNotExists() {
        let review = Review(json: [:])
        XCTAssertNil(review, "Review should not exists")
    }
    
    func testReviewWithValidateParamsShouldBeSuccess() {
        var json: JSON = ["author_name": "Test",
                          "rating": 0,
                          "text": "Test"]
        XCTAssertNotNil(Review(json: json), "Review should exists")
        
        json = [:]
        json["author_name"] = "Test"
        XCTAssertNil(Review(json: json), "Review should not exists")
        
        json = [:]
        json["rating"] = 0
        XCTAssertNil(Review(json: json), "Review should not exists")
        
        json = [:]
        json["text"] = "Test"
        XCTAssertNil(Review(json: json), "Review should not exists")
    }
    
    func testCarRepairParsingAllParamsShouldBeSuccess() {
        let json = self.localJSONFrom(fileName: "review")
        let review = Review(json: json ?? [:])
        
        XCTAssertTrue(review?.authorName.isEmpty == false, "Author Name should exists")
        XCTAssertNotNil(review?.authorPhotoURL, "Author Photo URL should exists")
        XCTAssertNotNil(review?.rating, "Rating should exists")
        XCTAssertTrue(review?.text.isEmpty == false, "Text should exists")
        XCTAssertTrue(review?.timeDescription?.isEmpty == false, "Time Description should exists")
        XCTAssertNotNil(review?.time, "Time should exists")
    }
}
