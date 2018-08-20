//
//  NetworkLogger.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 10/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import SwiftyJSON

class NetworkLogger: NSObject {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    class func logRequest(_ request: URLRequest) {
        self.logSeparator()
        
        if let url = request.url?.absoluteString {
            print("📩 Request: \(request.httpMethod!) \(url)")
        }
        
        if let headers = request.allHTTPHeaderFields {
            self.logHeaders(headers as [String: AnyObject])
        }
    }
    
    class func logResponse(_ response: URLResponse?, data: Data? = nil) {
        self.logSeparator()
        
        guard let response = response else {
            print("📦 Response: nil")
            return
        }
        
        if let url = response.url?.absoluteString {
            print("📦 Response: \(url)")
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            let localisedStatus = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode).capitalized
            print("Status: \(httpResponse.statusCode) - \(localisedStatus)")
        }
        
        if let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: AnyObject] {
            self.logHeaders(headers)
        }
        
        guard let data = data else { return }
        let json = JSON(data)
        
        if !json.isEmpty {
            print("JSON: \(json.debugDescription)")
        } else {
            
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                print("Data: \(string)")
            }
        }
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private class func logSeparator() {
        print("-----------------//-----------------")
    }
    
    private class func logHeaders(_ headers: [String: AnyObject]) {
        print("Headers: [")
        for (key, value) in headers {
            print("  \(key) : \(value)")
        }
        print("]")
    }
}

