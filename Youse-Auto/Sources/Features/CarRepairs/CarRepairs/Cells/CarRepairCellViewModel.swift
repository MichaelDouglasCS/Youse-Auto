//
//  CarRepairCellViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 13/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

struct CarRepairCellViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    let height: CGFloat = 270.0
    
    var placeID: String {
        return self.carRepair.placeID
    }
    
    var imageURL: URL? {
        return self.carRepair.image?.url
    }
    
    var name: String {
        return self.carRepair.name
    }
    
    var rating: Double? {
        return self.carRepair.rating
    }
    
    var address: NSAttributedString? {
        guard let address = self.carRepair.address else { return nil }
        let mutable = NSMutableAttributedString(string: "\(String.YouseAuto.address): \(address)",
                                                attributes: [.foregroundColor: UIColor.gray])
        
        if let range = mutable.string.range(of: String.YouseAuto.address) {
            mutable.addAttribute(.font,
                                 value: UIFont.boldSystemFont(ofSize: 12),
                                 range: mutable.string.nsRange(from: range))
        }
        
        return mutable
    }
    
    var distance: String? {
        guard let placeLocation = self.carRepair.location,
            let userLocation = LocationService.shared.lastLocation else { return nil }
        return userLocation.distance(from: placeLocation).kilometers
    }
    
    var availability: NSAttributedString? {
        return self.carRepair.isOpenFormatted
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var carRepair: CarRepair
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(carRepair: CarRepair) {
        self.carRepair = carRepair
    }
}
