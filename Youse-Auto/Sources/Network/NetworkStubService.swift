//
//  NetworkStubService.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 19/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import OHHTTPStubs

class NetworkStubService: NSObject {
    
    enum StubType {
        case carRepairsList
        case carRepairDetails
        case noConnection
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    /// This method is used to inject arguments at your test to mock your requests
    func addStubByArguments() {
        let arguments = ProcessInfo.processInfo.arguments
        
        if arguments.contains("TEST_CAR_REPAIRS_LIST") {
            self.addStub(for: .carRepairsList)
        }
        
        if arguments.contains("TEST_CAR_REPAIR_DETAILS") {
            self.addStub(for: .carRepairDetails)
        }
            
        if arguments.contains("TEST_NO_CONNECTION") {
            self.addStub(for: .noConnection)
        }
    }
    
    func addStub(for stubType: StubType) {
        
        switch stubType {
        case .carRepairsList:
            stub(condition: { (request) -> Bool in
                return request.url?.absoluteString.contains("nearbysearch/") ?? false
            }) { (_) in
                let path = OHPathForFile("carRepairsList.json", type(of: self)) ?? ""
                return OHHTTPStubsResponse(
                    fileAtPath: path,
                    statusCode: 200,
                    headers: ["Content-Type": "application/json"]
                )
            }
        case .carRepairDetails:
            stub(condition: { (request) -> Bool in
                return request.url?.absoluteString.contains("details/") ?? false
            }) { (_) in
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
}
