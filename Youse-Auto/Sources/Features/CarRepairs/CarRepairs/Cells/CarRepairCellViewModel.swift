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
    
    let height: CGFloat = 250.0
    
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
        guard let  address = self.carRepair.address else { return nil }
        let mutable = NSMutableAttributedString(string: "\(String.YouseAuto.address): \(address)",
                                                attributes: [.foregroundColor: UIColor.gray])
        
        if let range = mutable.string.range(of: String.YouseAuto.address) {
            mutable.addAttribute(.font,
                                 value: UIFont.boldSystemFont(ofSize: 12),
                                 range: mutable.string.nsRange(from: range))
        }
        
        return mutable
    }
    
    var availability: NSAttributedString? {
        guard let isOpenNow = self.carRepair.isOpenNow else { return nil }
        let title: String = isOpenNow ? String.YouseAuto.open : String.YouseAuto.closed
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
