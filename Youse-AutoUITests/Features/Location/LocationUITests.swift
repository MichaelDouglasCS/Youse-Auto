//
//  LocationUITests.swift
//  Youse-AutoUITests
//
//  Created by Michael Douglas on 10/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest

class LocationUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLocationShouldAppear() {
        
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Address: Rua Chilon, 193 - Vila Olimpia, São Paulo")/*[[".cells.containing(.staticText, identifier:\"W. B. A. Mecânica, Funil e Pintura\")",".cells.containing(.staticText, identifier:\"Address: Rua Chilon, 193 - Vila Olimpia, São Paulo\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["0.1 m"].tap()
        app.navigationBars["Details"].buttons["Car Repairs"].tap()
        
    }
}
