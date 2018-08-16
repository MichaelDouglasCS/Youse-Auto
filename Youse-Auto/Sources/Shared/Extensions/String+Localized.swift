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
        
        //*************************************************
        // MARK: - Car Repairs
        //*************************************************
        
        static var carRepairs: String { return "CAR_REPAIRS".localized }
        static var address: String { return "ADDRESS".localized }
        static var open: String { return "OPEN".localized }
        static var closed: String { return "CLOSED".localized }
        
        //*************************************************
        // MARK: - Car Repair Details
        //*************************************************
        
        static var details: String { return "DETAILS".localized }
        static var reviews: String { return "REVIEWS".localized }
        static var informations: String { return "INFORMATIONS".localized }
        
        //*************************************************
        // MARK: - Alerts
        //*************************************************
        
        static var ok: String { return "OK".localized }
        static var sorry: String { return "SORRY".localized }
        static var oops: String { return "OOPS".localized }
        static var noResultsFound: String { return "NO_RESULTS_FOUND".localized }
        static var noDetailsLoad: String { return "NO_DETAILS_LOAD".localized }
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
