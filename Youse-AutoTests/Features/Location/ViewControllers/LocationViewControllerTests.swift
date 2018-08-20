//
//  LocationViewControllerTests.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 20/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
@testable import Youse_Auto

class LocationViewControllerTests: XCTestCase {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var locationViewController: LocationViewController?
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        self.locationViewController = nil
        super.tearDown()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func testLocationViewControllerShouldInstantiate() {
        let storyboard = UIStoryboard(name: "Location", bundle: nil)
        let viewControllerID = String(describing: LocationViewController.self)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? LocationViewController
        self.locationViewController = viewController
        
        self.locationViewController?.setupUI(with: LocationViewModel())
        _ = self.locationViewController?.view
        
        XCTAssertNotNil(self.locationViewController, "LocationViewController should be instantiate")
    }
}
