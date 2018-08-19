//
//  UIColor+Style.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 11/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct YouseAuto {
        static var blue: UIColor { return UIColor(hexadecimal: 0x005493) }
        static var warmYellow: UIColor { return UIColor(hexadecimal: 0xFF9C00) }
        static var green: UIColor { return UIColor(hexadecimal: 0x008F00) }
        static var red: UIColor { return UIColor(hexadecimal: 0xFF2600) }
    }
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    convenience init(hexadecimal: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hexadecimal >> 16) & 0xff)
        let green = CGFloat((hexadecimal >> 8) & 0xff)
        let blue = CGFloat(hexadecimal & 0xff)
        
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
