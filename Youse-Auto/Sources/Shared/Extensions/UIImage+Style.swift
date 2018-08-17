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
        static var carOil: UIImage? { return UIImage(named: "icon-car-oil") }
        
        //*************************************************
        // MARK: - Car Repair Details
        //*************************************************
        
        static var carList: UIImage? { return UIImage(named: "icon-car-list") }
        static var location: UIImage? { return UIImage(named: "icon-location")?.withRenderingMode(.alwaysTemplate) }
        static var clock: UIImage? { return UIImage(named: "icon-clock")?.withRenderingMode(.alwaysTemplate) }
        static var phone: UIImage? { return UIImage(named: "icon-phone")?.withRenderingMode(.alwaysTemplate) }
        static var user: UIImage? { return UIImage(named: "icon-user")?.withRenderingMode(.alwaysTemplate) }
    }
}
