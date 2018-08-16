//
//  UIImage+Style.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 13/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

extension UIImage {
    
    struct YouseAuto {
        
        //*************************************************
        // MARK: - Car Repairs
        //*************************************************
        
        static var carRepairCover: UIImage? { return UIImage(named: "car-repair-cover") }
        static var carRepairOil: UIImage? { return UIImage(named: "car-repair-oil") }
        static var carRepairDetails: UIImage? { return UIImage(named: "car-repair-details") }
        
        //*************************************************
        // MARK: - Car Repair Details
        //*************************************************
        
        static var localization: UIImage? { return UIImage(named: "location")?.withRenderingMode(.alwaysTemplate) }
        static var clock: UIImage? { return UIImage(named: "clock")?.withRenderingMode(.alwaysTemplate) }
        static var phone: UIImage? { return UIImage(named: "phone")?.withRenderingMode(.alwaysTemplate) }
    }
}
