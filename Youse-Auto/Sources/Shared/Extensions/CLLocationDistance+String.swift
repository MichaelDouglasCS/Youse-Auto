//
//  CLLocationDistance+String.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 17/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import CoreLocation

extension CLLocationDistance {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var kilometers: String {
        let kilometers = Double(self / 1000.0)
        let string = kilometers.toString(withDecimalPlaces: 1)
        let unit = string < "1.0" ? " m" : " km"
        return string + unit
    }
}
