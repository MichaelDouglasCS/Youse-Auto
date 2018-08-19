//
//  XCTestCase+Utils.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import XCTest
import CoreLocation
import SwiftyJSON
@testable import Youse_Auto

extension XCTestCase {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var userLocationYouse: CLLocation {
        return CLLocation(latitude: -23.5941355, longitude: -46.6802735)
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func localJSONFrom(fileName: String) -> JSON? {
        let bundle = Bundle(for: type(of: self))
        
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                    options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                return JSON(json)
            } catch let error {
                print(error.localizedDescription)
                return JSON()
            }
        } else {
            print("Invalid filename/path.")
            return JSON()
        }
    }
}
