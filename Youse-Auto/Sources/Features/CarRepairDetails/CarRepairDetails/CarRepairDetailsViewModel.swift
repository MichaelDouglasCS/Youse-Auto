//
//  CarRepairDetailsViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation

class CarRepairDetailsViewModel: NSObject {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var provider: CarRepairDetailsProvider
    private var placeID: String
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(provider: CarRepairDetailsProvider, placeID: String) {
        self.provider = provider
        self.placeID = placeID
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    /// This method is used to load a list of Car Repairs
    ///
    /// - Parameters:
    ///   - type: A property to set what kind of request will be performed
    ///   - completion: This parameter produces (isSuccess: Bool, localizedError: String?) -> Void
    func loadData(completion: @escaping (_ error: String?) -> Void) {
        self.provider.carRepairDetails(byPlaceID: self.placeID) { (carRepairDetails, error) in
            completion(error)
        }
    }
}
