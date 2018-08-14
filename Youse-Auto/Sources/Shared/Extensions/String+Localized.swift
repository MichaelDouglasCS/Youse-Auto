//
//  String+Localized.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 10/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

extension String {
    
    struct YouseAuto {
        static var noConnection: String { return "NO_CONECTION_ERROR".localized }
    }
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}
