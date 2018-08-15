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
    
    typealias CarRepairDetails = (_ carRepairDetails: String?, _ error: String?) -> Void
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    /// This method is used to load Car Repair Details
    ///
    /// - Parameters:
    ///   - placeID: Used to identify Car Repair Details to be loaded.
    ///   - completion: A closure that produces (carRepairDetails: String?, error: String?) -> Void
    func carRepairDetails(byPlaceID placeID: String,
                          completion: @escaping CarRepairDetails) {
        
        NetworkService.CarRepair.details(fromPlaceID: placeID).execute { (json, response) in
            
            switch response {
            case .success:
                print(json.description)
                completion("", nil)
            case .error(let error):
                completion(nil, error.rawValue.localized)
            }
        }
    }
}
