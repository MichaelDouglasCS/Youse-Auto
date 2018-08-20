//
//  StubService.swift
//  Youse-AutoTests
//
//  Created by Michael Douglas on 18/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import OHHTTPStubs
import XCTest
@testable import Youse_Auto

class StubService: NSObject {
    
    enum StubType {
        case carRepairsList
        case carRepairDetails
        case noConnection
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func addStub(for stubType: StubType) {
        
        switch stubType {
        case .carRepairsList:
            stub(condition: isHost("maps.googleapis.com")) { (_) in
                let path = OHPathForFile("carRepairsList.json", type(of: self)) ?? ""
                return OHHTTPStubsResponse(
                    fileAtPath: path,
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"]
                )
            }
        case .carRepairDetails:
            stub(condition: isHost("maps.googleapis.com")) { (_) in
                let path = OHPathForFile("carRepairDetails.json", type(of: self)) ?? ""
                return OHHTTPStubsResponse(
                    fileAtPath: path,
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"]
                )
            }
        case .noConnection:
            stub(condition: isHost("maps.googleapis.com")) { (_) in
                let notConnected = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
                return OHHTTPStubsResponse(error: notConnected)
            }
        }
    }
    
    class func removeAllStubs() {
        OHHTTPStubs.removeAllStubs()
    }
}
