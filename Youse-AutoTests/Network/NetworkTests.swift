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
import OHHTTPStubs
@testable import Youse_Auto

class NetworkTests: XCTestCase {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    var locationValid = CLLocation(latitude: -23.5941355, longitude: -46.6802735)
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    // Car Repairs List
    
    func testListNearbyWithLocationShouldSuccess() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        
        NetworkService.CarRepair.listNearby(to: location).execute { (_, response) in
            XCTAssertTrue(response.isSuccess, "Response should success")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testListNearbyWithLocationShouldFailed() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        
        stub(condition: isHost("maps.googleapis.com")) { (_) in
            let notConnected = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error: notConnected)
        }
        
        NetworkService.CarRepair.listNearby(to: location).execute { (_, response) in
            XCTAssertTrue(!response.isSuccess, "Response should Failed")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testListNearbyWithLocationShouldResultsExists() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        
        NetworkService.CarRepair.listNearby(to: location).execute { (json, _) in
            let results = json["results"].arrayValue
            XCTAssertTrue(!results.isEmpty, "Results should exists")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testListNearbyWithNextPageTokenShouldResultsExists() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        
        NetworkService.CarRepair.listNearby(to: location).execute { (json, _) in
            let nextPage = json["next_page_token"].string
            XCTAssertNotNil(nextPage, "Next Page Token should exists")
            
            NetworkService.CarRepair.listNearby(to: location,
                                                    nextPage: nextPage).execute { (json, _) in
                let results = json["results"].arrayValue
                XCTAssertTrue(!results.isEmpty, "Results should exists")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    // Car Repair Details

    func testDetailsWithValidPlaceIDShouldSuccess() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        
        NetworkService.CarRepair.listNearby(to: location).execute { (json, _) in
            let results = json["results"].arrayValue
            let placeID = results.first?["place_id"].string ?? ""
            XCTAssertTrue(!placeID.isEmpty, "placeID should exists")
            
            NetworkService.CarRepair.details(fromPlaceID: placeID).execute(completion: { (_, response) in
                XCTAssertTrue(response.isSuccess, "Response should success")
                expectation.fulfill()
            })
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testDetailsWithValidPlaceIDShouldResultsExists() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        
        NetworkService.CarRepair.listNearby(to: location).execute { (json, _) in
            let results = json["results"].arrayValue
            let placeID = results.first?["place_id"].string ?? ""
            XCTAssertTrue(!placeID.isEmpty, "placeID should exists")
            
            NetworkService.CarRepair.details(fromPlaceID: placeID).execute(completion: { (json, _) in
                let result = json["result"]
                XCTAssertTrue(!result.isEmpty, "Results should exists")
                expectation.fulfill()
            })
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testLocalizedErrorShouldExists() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        
        stub(condition: isHost("maps.googleapis.com")) { (_) in
            let notConnected = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error: notConnected)
        }
        
        NetworkService.CarRepair.listNearby(to: location).execute { (_, response) in
            XCTAssertTrue(!response.localizedError.isEmpty, "LocalizedError Should Exists")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testImageWithValidReferenceIDShouldImageExists() {
        let expectation = self.expectation(description: #function)
        let location = self.locationValid
        
        NetworkService.CarRepair.listNearby(to: location).execute { (json, _) in
            let results = json["results"].arrayValue
            let hasPhoto = results.filter({ !$0["photos"].arrayValue.isEmpty })
            let photo = hasPhoto.first?["photos"].arrayValue.first
            let photoID = photo?["photo_reference"].string ?? ""
            let width = photo?["width"].int ?? 400
            let height = photo?["height"].int
            
            let path = NetworkService.CarRepair.image(fromReferenceID: photoID,
                                                      width: width,
                                                      height: height).path
            
            if let url = URL(string: path),
                let data = try? Data(contentsOf: url) {
                XCTAssertNotNil(UIImage(data: data), "Image should exists")
                expectation.fulfill()
            } else {
                XCTAssertTrue(false, "Image should exists")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 30.0)
    }
    
    func testImageWithValidReferenceIDShouldImageNotExists() {
        let expectation = self.expectation(description: #function)
        let path = NetworkService.CarRepair.image(fromReferenceID: "",
                                                  width: 0,
                                                  height: 0).path
        
        if let url = URL(string: path),
            let data = try? Data(contentsOf: url) {
            XCTAssertNil(UIImage(data: data), "Image should not exists")
            expectation.fulfill()
        } else {
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30.0)
    }
}
