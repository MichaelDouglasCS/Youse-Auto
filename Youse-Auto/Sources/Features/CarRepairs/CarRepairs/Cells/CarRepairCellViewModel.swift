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
    
    let height: CGFloat = 250.0
    
    var imageURL: URL? {
        return self.carRepair.imageReference?.url
    }
    
    var name: String? {
        return self.carRepair.name
    }
    
    var rating: String? {
        return self.carRepair.rating?.toString(withDecimalPlaces: 1)
    }
    
    var address: NSAttributedString? {
        guard let  addressString = self.carRepair.address else { return nil }
        let mutable = NSMutableAttributedString(string: "\(Constants.address): \(addressString)")
        
        if let range = mutable.string.range(of: Constants.address) {
            mutable.addAttribute(NSAttributedStringKey.font,
                                 value: UIFont.boldSystemFont(ofSize: 11),
                                 range: mutable.string.nsRange(from: range))
        }
        
        return mutable
    }
    
    var availability: NSAttributedString? {
        let title: String = carRepair.isOpenNow == true ? Constants.opened : Constants.closed
        let color: UIColor = carRepair.isOpenNow == true ? UIColor.YouseAuto.green : UIColor.YouseAuto.red
        
        return NSMutableAttributedString(string: title,
                                         attributes: [NSAttributedStringKey.foregroundColor: color])
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
