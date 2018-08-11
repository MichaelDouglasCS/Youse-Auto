//
//  String+Localized.swift
//  Youse-Challenge
//
//  Created by Michael Douglas on 10/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//*************************************************
// MARK: - String iHungry
//*************************************************

extension String {
    
    struct iHungry {
        
        //*************************
        // Alerts
        //*************************
    
        static var noConnection: String { return "ST_NO_CONECTION".localized }
    }
}

//*************************************************
// MARK: - String Localized
//*************************************************

extension String {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}
