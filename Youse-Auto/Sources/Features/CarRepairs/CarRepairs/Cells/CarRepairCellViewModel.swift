//
//  CarRepairCellViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 13/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class CarRepairCellViewModel: NSObject {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    static let height: CGFloat = 250.0
    let imageURL: URL?
    let name: String?
    let rating: String?
    let address: String?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(carRepair: CarRepair) {
        self.imageURL = carRepair.imageReference?.url
        self.name = carRepair.name
        self.rating = carRepair.rating?.toString(withDecimalPlaces: 1)
        self.address = carRepair.address
    }
}
