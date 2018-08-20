//
//  CellViewModelsTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 19/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CellViewModelsTests: XCTestCase {
    
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
    
    func testGalleryCellViewModelShouldNumberOfItemsEqual() {
        let json = self.localJSONFrom(fileName: "photo")
        if let photo = Photo(json: json ?? [:]) {
            let photos: [Photo] = [photo, photo, photo]
            let viewModel = GalleryCellViewModel(images: photos)
            XCTAssertEqual(viewModel.numberOfItems(inSection: 0), photos.count, "Number of Items should be equal to 3")
        } else {
            XCTAssertTrue(false, "Photo should exists")
        }
    }
    
    func testGalleryCollectionCellViewModelShouldURLExists() {
        let json = self.localJSONFrom(fileName: "photo")
        
        if let photo = Photo(json: json ?? [:]) {
            let viewModel = GalleryCollectionCellViewModel(image: photo)
            XCTAssertNotNil(viewModel.url, "URL should exists")
        } else {
            XCTAssertTrue(false, "Photo should exists")
        }
    }
    
    func testDetailsCellViewModelAllParamsShouldExists() {
        let json = self.localJSONFrom(fileName: "carRepairDetails")
        
        if let carRepairDetails = CarRepairDetails(json: json?["result"] ?? [:]) {
            let viewModel = DetailsCellViewModel(details: carRepairDetails)
            XCTAssertTrue(viewModel.name.isEmpty == false, "Name should exists")
            XCTAssertNotNil(viewModel.rating, "Rating should exists")
            XCTAssertTrue(viewModel.distance?.isEmpty == false, "Distance should exists")
            XCTAssertNotNil(viewModel.availability, "Availability should exists")
            XCTAssertTrue(viewModel.phoneNumber.isEmpty == false, "Phone Number should exists")
            XCTAssertTrue(viewModel.address.isEmpty == false, "Address should exists")
        } else {
            XCTAssertTrue(false, "Car Repair Details should exists")
        }
    }
    
    func testDetailsCellViewModelDistanceShouldBeEqual() {
        let expectation = self.expectation(description: #function)
        let json = self.localJSONFrom(fileName: "carRepairDetails")
        
        LocationService.shared.getLocation(success: { (_) in
            if let carRepairDetails = CarRepairDetails(json: json?["result"] ?? [:]),
                let placeLocation = carRepairDetails.location {
                let viewModel = DetailsCellViewModel(details: carRepairDetails)
                let userLocation = self.userLocationYouse
                let distance = userLocation.distance(from: placeLocation).kilometers
                
                XCTAssertEqual(viewModel.distance, distance, "Distance should be equal")
                expectation.fulfill()
            } else {
                XCTAssertTrue(false, "Car Repair Details should exist")
                expectation.fulfill()
            }
        }) { (error) in
            XCTAssertTrue(false, "Location should exist. Error: \(error?.localized ?? "")")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: self.timeout)
    }
    
    func testContactInfoCellViewModelAllParamsShouldExists() {
        let viewModel = ContactInfoCellViewModel(icon: UIImage(),
                                                 title: "Test",
                                                 attributedTitle: NSAttributedString(string: "Test"),
                                                 content: "Test")
        XCTAssertTrue(viewModel.title.isEmpty == false, "Title should exists")
        XCTAssertNotNil(viewModel.attributedTitle, "AttributedTitle should exists")
        XCTAssertTrue(viewModel.content?.isEmpty == false, "Content should exists")
    }
    
    func testReviewCellViewModelAllParamsShouldExists() {
        let json = self.localJSONFrom(fileName: "review")
        
        if let review = Review(json: json ?? [:]) {
            let viewModel = ReviewCellViewModel(review: review)
            
            XCTAssertTrue(viewModel.authorName.isEmpty == false, "AuthorName should exists")
            XCTAssertNotNil(viewModel.authorPhotoURL, "Author Photo URL should exists")
            XCTAssertNotNil(viewModel.rating, "Rating should exists")
            XCTAssertTrue(viewModel.text.isEmpty == false, "Text should exists")
            XCTAssertTrue(viewModel.timeDescription?.isEmpty == false, "Time Description should exists")
        } else {
            XCTAssertTrue(false, "Review should exists")
        }
    }
}
