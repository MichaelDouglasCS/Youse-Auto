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
    // MARK: - Definitions
    //*************************************************
    
    typealias CarRepairsResponse = (_ carRepairs: [CarRepair], _ nextPage: String?, _ error: String?) -> Void
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    /// This method is used to load a list of Car Repairs
    ///
    /// - Parameters:
    ///   - location: Custom Path for your Request.
    ///   - nextPage: Params of your Request, nil by default
    ///   - completion: A closure that produces (carRepairs: [CarRepair], nextPage: String?, error: String?) -> Void
    func carRepairs(by location: CLLocation,
                    nextPage next: String? = nil,
                    completion: @escaping CarRepairsResponse) {
        
        NetworkService.CarRepair.listNearby(to: location,
                                            nextPage: next).execute { (json, response) in
                                                
            switch response {
            case .success:
                var carRepairs: [CarRepair] = []
                let nextPage = json["next_page_token"].string
                
                json["results"].array?.forEach({ (carRepairJSON) in
                    if let carRepair = CarRepair(json: carRepairJSON) {
                        carRepairs.append(carRepair)
                    }
                })
                completion(carRepairs, nextPage, nil)
            case .error(let error):
                completion([], nil, error.rawValue.localized)
            }
        }
    }
}
