//
//  NetworkService.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 10/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

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
        case serverError = "SERVER_ERROR"
        case noConnection = "NO_CONNECTION_ERROR"
    }
    
    case success
    case error(NetworkResponse.Error)
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .error:
            return false
        }
    }
    
    var localizedError: String {
        switch self {
        case .success:
            return ""
        case .error(let type):
            return type.rawValue.localized
        }
    }

    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(_ response: HTTPURLResponse?, json: JSON) {
        
        if let httpResponse = response {
            switch httpResponse.statusCode {
            case 200 ..< 300:
                self = .success
            default:
                self = .error(.serverError)
            }
        } else if NetworkReachabilityManager()?.isReachable == false {
            self = .error(.noConnection)
        } else {
            self = .error(.serverError)
        }
        
        // The API uses "status" as response code
        if let status = json["status"].string,
            !status.contains("OK") {
            self = .error(.serverError)
        }
    }
}

//*************************************************
// MARK: - NetworkService
//*************************************************

enum NetworkService {
    
    case mobile(NetworkContract)
    
    typealias NetworkContract = (method: HTTPMethod, path: String)
    
    private struct API {
        static public let key: String = "AIzaSyApXi8qbjwN_Gv3hsVYS1xehrInSxYVTvo"
        
        static public let base: String = "https://maps.googleapis.com/maps/api"
        static public var mobile: String = API.base
    }
    
    struct CarRepair {
        
        static func listNearby(to location: CLLocation,
                               nextPage next: String? = nil) -> NetworkService {
            
            if let pageToken = next {
                return .mobile((method: .get,
                                path: "/place/nearbysearch/json?pagetoken=\(pageToken)&key=\(API.key)"))
            }
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude

            return .mobile((method: .get,
                            path: "/place/nearbysearch/json?location=\(latitude),\(longitude)&rankby=distance&type=car_repair&key=\(API.key)"))
        }
        
        static func details(fromPlaceID placeID: String) -> NetworkService {
            return .mobile((method: .get,
                            path: "/place/details/json?placeid=\(placeID)&key=\(API.key)"))
        }
        
        static func image(fromReferenceID referenceID: String,
                          width: Int,
                          height: Int?) -> NetworkService {
            var path = "/place/photo?maxwidth=\(width)&"
            
            if let height = height {
                path.append("maxheight=\(height)&")
            }
            
            path.append("photoreference=\(referenceID)&key=\(API.key)")
            
            return .mobile((method: .get,
                            path: path))
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
            return NetworkService.API.mobile + contract.path
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    /// This method is used to execute requests
    ///
    /// - Parameters:
    ///   - aPath: Custom Path for your Request, nil by default.
    ///   - params: Params of your Request, nil by default
    ///   - completion: A closure that produces (JSON, NetworkResponse) -> Void
    func execute(path: String? = nil,
                 params: [String: Any]? = nil,
                 completion: @escaping (JSON, NetworkResponse) -> Void) {
        let stubService = NetworkStubService()
        stubService.addStubByArguments()
        
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
                
                completion(json, NetworkResponse(dataResponse.response, json: json))
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

