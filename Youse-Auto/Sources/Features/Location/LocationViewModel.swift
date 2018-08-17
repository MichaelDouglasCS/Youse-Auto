//
//  LocationViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import CoreLocation

struct LocationViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var message: String {
        return String.YouseAuto.nearYou
    }
    
    var buttonTitle: String {
        return String.YouseAuto.continueNext
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func getLocation(completion: @escaping (CLLocation?) -> Void) {
        LocationService.shared.requestAuthorization()
        LocationService.shared.getLocation(success: { (location) in
            completion(location)
        }) { (_) in
            completion(nil)
        }
    }
}
