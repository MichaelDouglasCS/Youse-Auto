//
//  PhoneService.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

struct PhoneService {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    static func canCall(toNumber number: String) -> Bool {
        
        if let url = URL(string: "tel://\(number)") {
            return UIApplication.shared.canOpenURL(url)
        } else {
            return false
        }
    }
    
    static func performCall(toNumber number: String) {
        
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
