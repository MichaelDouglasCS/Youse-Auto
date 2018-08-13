//
//  Double+Utils.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 13/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation

extension Double {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func toString(withDecimalPlaces decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}
