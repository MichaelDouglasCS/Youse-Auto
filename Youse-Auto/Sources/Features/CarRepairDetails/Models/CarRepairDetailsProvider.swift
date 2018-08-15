//
//  CarRepairDetailsProvider.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation

class CarRepairDetailsProvider: NSObject {
    
    //*************************************************
    // MARK: - Definitions
    //*************************************************
    
    typealias CarRepairDetailsResponse = (_ carRepairDetails: CarRepairDetails?, _ error: String?) -> Void
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    /// This method is used to load Car Repair Details
    ///
    /// - Parameters:
    ///   - placeID: Used to identify Car Repair Details to be loaded.
    ///   - completion: A closure that produces (carRepairDetails: CarRepairDetails?, error: String?) -> Void
    func carRepairDetails(byPlaceID placeID: String,
                          completion: @escaping CarRepairDetailsResponse) {
        
        NetworkService.CarRepair.details(fromPlaceID: placeID).execute { (json, response) in
            switch response {
            case .success:
                let carRepairDetails = CarRepairDetails(json: json["result"])
                completion(carRepairDetails, nil)
            case .error(let error):
                completion(nil, error.rawValue.localized)
            }
        }
    }
}
