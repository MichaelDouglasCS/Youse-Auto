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
    
    var rating: Double? {
        return self.carRepair.rating
    }
    
    var address: NSAttributedString? {
        guard let  addressString = self.carRepair.address else { return nil }
        let mutable = NSMutableAttributedString(string: "\(Constants.address): \(addressString)",
                                                attributes: [.foregroundColor: UIColor.gray])
        
        if let range = mutable.string.range(of: Constants.address) {
            mutable.addAttribute(.font,
                                 value: UIFont.boldSystemFont(ofSize: 12),
                                 range: mutable.string.nsRange(from: range))
        }
        
        return mutable
    }
    
    var availability: NSAttributedString? {
        guard let isOpenNow = self.carRepair.isOpenNow else { return nil }
        let title: String = isOpenNow ? Constants.opened : Constants.closed
        let color: UIColor = isOpenNow ? UIColor.YouseAuto.green : UIColor.YouseAuto.red
        let font = UIFont.boldSystemFont(ofSize: 12)
        
        return NSMutableAttributedString(string: title,
                                         attributes: [.foregroundColor: color, .font: font])
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
