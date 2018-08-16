//
//  DetailsCellViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

struct DetailsCellViewModel: CarRepairDetailsCellProtocol {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var section: CarRepairDetailsViewModel.Sections {
        return .basicInfo
    }
    
    var height: CGFloat {
        return UITableViewAutomaticDimension
    }
    
    var name: String {
        return self.carRepairDetails.name
    }
    
    var rating: Double? {
        return self.carRepairDetails.rating
    }
    
    var distance: String? {
        return "10km"
    }
    
    var availability: NSAttributedString? {
        guard let isOpenNow = self.carRepairDetails.isOpenNow else { return nil }
        let title: String = isOpenNow ? String.YouseAuto.open : String.YouseAuto.closed
        let color: UIColor = isOpenNow ? UIColor.YouseAuto.green : UIColor.YouseAuto.red
        let font = UIFont.boldSystemFont(ofSize: 13)
        
        return NSMutableAttributedString(string: title,
                                         attributes: [.foregroundColor: color, .font: font])
    }
    
    var hasPhone: Bool {
        let number = self.carRepairDetails.formattedPhone?.digits ?? ""
        return PhoneService.canCall(toNumber: number)
    }
    
    var phoneNumber: String {
        return self.carRepairDetails.formattedPhone?.digits ?? ""
    }
    
    var hasDirections: Bool {
        return self.carRepairDetails.address != nil
    }
    
    var address: String {
        return self.carRepairDetails.address ?? ""
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var carRepairDetails: CarRepairDetails
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(details: CarRepairDetails) {
        self.carRepairDetails = details
    }
}


