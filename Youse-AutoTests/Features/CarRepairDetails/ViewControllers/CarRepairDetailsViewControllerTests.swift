//
//  CarRepairDetailsViewControllerTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 20/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CarRepairDetailsViewControllerTests: XCTestCase {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var carRepairDetailsViewController: CarRepairDetailsViewController?
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        self.carRepairDetailsViewController = nil
        super.tearDown()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func testCarRepairDetailsViewControllerShouldInstantiate() {
        let storyboard = UIStoryboard(name: "CarRepairDetails", bundle: nil)
        let viewControllerID = String(describing: CarRepairDetailsViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? CarRepairDetailsViewController
        self.carRepairDetailsViewController = viewController
        
        let viewModel = CarRepairDetailsViewModel(provider: CarRepairDetailsProvider(),
                                                  placeID: "")
        self.carRepairDetailsViewController?.setupUI(with: viewModel)
        _ = self.carRepairDetailsViewController?.view
        XCTAssertNotNil(self.carRepairDetailsViewController, "Should be instantiate")
    }
    
    func testCarRepairDetailsViewControllerShouldLoadCells() {
        let expectation = self.expectation(description: #function)
        let stubService = StubService()
        stubService.addStub(for: .carRepairDetails)
        
        let storyboard = UIStoryboard(name: "CarRepairDetails", bundle: nil)
        let viewControllerID = String(describing: CarRepairDetailsViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? CarRepairDetailsViewController
        self.carRepairDetailsViewController = viewController
        
        let viewModel = CarRepairDetailsViewModel(provider: CarRepairDetailsProvider(),
                                                  placeID: "")
        self.carRepairDetailsViewController?.setupUI(with: viewModel)
        _ = self.carRepairDetailsViewController?.view
        
        self.carRepairDetailsViewController?.loadData {
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: self.timeout) { (_) in
            typealias sections = CarRepairDetailsViewModel.Sections
            let viewModel = self.carRepairDetailsViewController?.viewModel
            
            XCTAssertTrue(viewModel?.numberOfRows(inSection: sections.basicInfo.rawValue) ?? 0 == 2, "Should load 2 Basic Info cells")
            
            XCTAssertTrue(viewModel?.numberOfRows(inSection: sections.contactInfo.rawValue) ?? 0 == 3, "Should load 3 Contact Info cells")
            
            XCTAssertTrue(viewModel?.numberOfRows(inSection: sections.reviews.rawValue) ?? 0 == 5, "Should load 5 Review cells")
        }
    }
}
