//
//  CarRepairsViewControllerTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 20/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class CarRepairsViewControllerTests: XCTestCase {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var carRepairsViewController: CarRepairsViewController?
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        self.carRepairsViewController = nil
        super.tearDown()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func testCarRepairsViewControllerShouldInstantiate() {
        let storyboard = UIStoryboard(name: "CarRepairs", bundle: nil)
        let viewControllerID = String(describing: CarRepairsViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? CarRepairsViewController
        self.carRepairsViewController = viewController
        
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        self.carRepairsViewController?.setupUI(with: viewModel)
        _ = self.carRepairsViewController?.view
        XCTAssertNotNil(self.carRepairsViewController, "Should be instantiate")
    }
    
    func testCarRepairsViewControllerShouldLoad2Cells() {
        let expectation = self.expectation(description: #function)
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        let storyboard = UIStoryboard(name: "CarRepairs", bundle: nil)
        let viewControllerID = String(describing: CarRepairsViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? CarRepairsViewController
        self.carRepairsViewController = viewController
        
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        self.carRepairsViewController?.setupUI(with: viewModel)
        _ = self.carRepairsViewController?.view
        
        self.carRepairsViewController?.loadData {
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: self.timeout) { (_) in
            let numberOfRows = self.carRepairsViewController?.viewModel.numberOfRows()
            XCTAssertTrue(numberOfRows ?? 0 == 2, "Should load 2 cells")
        }
    }
    
    func testCarRepairsViewControllerShouldNotLoadCells() {
        let expectation = self.expectation(description: #function)
        let stubService = StubService()
        stubService.addStub(for: .noConnection)
        
        let storyboard = UIStoryboard(name: "CarRepairs", bundle: nil)
        let viewControllerID = String(describing: CarRepairsViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? CarRepairsViewController
        self.carRepairsViewController = viewController
        
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        self.carRepairsViewController?.setupUI(with: viewModel)
        _ = self.carRepairsViewController?.view
        
        self.carRepairsViewController?.loadData {
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: self.timeout) { (_) in
            let numberOfRows = self.carRepairsViewController?.viewModel.numberOfRows()
            XCTAssertTrue(numberOfRows ?? 0 == 0, "Should not load any cells")
        }
    }
    
    func testCarRepairsViewControllerShouldBringMoreLoad4Cells() {
        let expectation = self.expectation(description: #function)
        let stubService = StubService()
        stubService.addStub(for: .carRepairsList)
        
        let storyboard = UIStoryboard(name: "CarRepairs", bundle: nil)
        let viewControllerID = String(describing: CarRepairsViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? CarRepairsViewController
        self.carRepairsViewController = viewController
        
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        self.carRepairsViewController?.setupUI(with: viewModel)
        _ = self.carRepairsViewController?.view
        
        self.carRepairsViewController?.loadData {
            self.carRepairsViewController?.bringMoreData {
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: self.timeout) { (_) in
            let numberOfRows = self.carRepairsViewController?.viewModel.numberOfRows()
            XCTAssertTrue(numberOfRows ?? 0 == 4, "Should load 4 cells")
        }
    }
    
    func testCarRepairsViewControllerShouldNotBringMoreCells() {
        let expectation = self.expectation(description: #function)
        let stubService = StubService()
        stubService.addStub(for: .noConnection)
        
        let storyboard = UIStoryboard(name: "CarRepairs", bundle: nil)
        let viewControllerID = String(describing: CarRepairsViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? CarRepairsViewController
        self.carRepairsViewController = viewController
        
        let viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        self.carRepairsViewController?.setupUI(with: viewModel)
        _ = self.carRepairsViewController?.view
        
        self.carRepairsViewController?.bringMoreData {
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: self.timeout) { (_) in
            let numberOfRows = self.carRepairsViewController?.viewModel.numberOfRows()
            XCTAssertTrue(numberOfRows ?? 0 == 0, "Should not bring more cells")
        }
    }
}
