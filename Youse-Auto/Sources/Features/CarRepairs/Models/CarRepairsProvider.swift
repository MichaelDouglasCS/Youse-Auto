//
//  CarRepairsProvider.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 12/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import CoreLocation

class CarRepairsProvider: NSObject {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    /// This method is used to load a list of Car Repairs
    ///
    /// - Parameters:
    ///   - location: Custom Path for your Request.
    ///   - nextPage: Params of your Request
    ///   - completion: This method produces (nextPage: String?, localizedError: String?) -> Void
    func loadCarRepairs(by location: CLLocation,
                        nextPage next: String? = nil,
                        completion: @escaping (_ nextPage: String?, _ localizedError: String?) -> Void) {
        
        NetworkService.CarRepair.listNearby(to: location, nextPage: next).execute { (json, response) in
            
            switch response {
            case .success:
                let nextPage = json["next_page_token"].string
                
                completion(nextPage, nil)
            case .error(let error):
                completion(nil, error.rawValue.localized)
            }
        }
    }
}
