//
//  NetworkService.swift
//  Youse-Challenge
//
//  Created by Michael Douglas on 10/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

//*************************************************
// MARK: - Definitions
//*************************************************

typealias NetworkResult = (NetworkResponse) -> Void

//*************************************************
// MARK: - NetworkResponse
//*************************************************

enum NetworkResponse {
    
    enum Error: String {
        case unkown = "ST_SERVER_ERROR"
        case serviceUnavailable = "ST_SERVICE_UNAVAILABLE"
        case noConnection = "ST_NO_CONNECTION"
    }
    
    case success
    case error(NetworkResponse.Error)
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var localizedError: String {
        switch self {
        case .error(let type):
            return type.rawValue.localized
        default:
            return ""
        }
    }

    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(_ response: HTTPURLResponse?) {
        
        if let httpResponse = response {
            switch httpResponse.statusCode {
            case 200..<300:
                self = .success
            case 503:
                self = .error(.serviceUnavailable)
            default:
                self = .error(.unkown)
            }
        } else if NetworkReachabilityManager()?.isReachable == false {
            self = .error(.noConnection)
        } else {
            self = .error(.unkown)
        }
    }
}

//*************************************************
// MARK: - NetworkRequest
//*************************************************

enum NetworkRequest {
    
    case mobile(NetworkContract)
    
    typealias NetworkContract = (method: HTTPMethod, path: String)
    
    struct API {
        static public let key: String = "AIzaSyApXi8qbjwN_Gv3hsVYS1xehrInSxYVTvo"
        
        static public let base: String = "https://maps.googleapis.com/maps/api"
        static public var mobile: String = API.base
    }
    
    struct CarRepairShop {
        
        static func listNearby(to location: CLLocation, withNext next: String?) -> NetworkRequest {
            
            if let pageToken = next {
                return .mobile((method: .get, path: "/place/nearbysearch/json?/json?pagetoken=\(pageToken)&key=\(API.key)"))
            }
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude

            return .mobile((method: .get, path: "/place/nearbysearch/json?location=\(latitude),\(longitude)&rankby=distance&type=car_repair&key=\(API.key)"))
        }
    }
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var method: HTTPMethod {
        switch self {
        case .mobile(let contract):
            return contract.method
        }
    }
    
    var path: String {
        switch self {
        case .mobile(let contract):
            return NetworkRequest.API.mobile + contract.path
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func execute(path: String? = nil,
                 params: [String: Any]? = nil,
                 completion: @escaping (JSON, NetworkResponse) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let method = self.method
            let finalPath = path ?? self.path
            let closure = { (_ dataResponse: DataResponse<Any>) in
                var json: JSON = [:]
                
                NetworkLogger.logResponse(dataResponse.response, data: dataResponse.data)
                
                switch dataResponse.result {
                case .success(let data):
                    json = JSON(data)
                default: break
                }
                
                completion(json, NetworkResponse(dataResponse.response))
            }
            
            let headers = self.getHeader()
            
            if let request = Alamofire.request(finalPath,
                                               method: method,
                                               parameters: params,
                                               encoding: JSONEncoding.default,
                                               headers: headers).responseJSON(completionHandler: closure).request {
                NetworkLogger.logRequest(request)
            }
        }
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func getHeader() -> HTTPHeaders {
        let headers = Alamofire.SessionManager.defaultHTTPHeaders
        return headers
    }
}
