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
        guard let placeLocation = self.carRepairDetails.location,
                let userLocation = LocationService.shared.lastLocation else { return nil }
        return userLocation.distance(from: placeLocation).kilometers
    }
    
    var availability: NSAttributedString? {
        return self.carRepairDetails.isOpenFormatted
    }
    
    var hasPhone: Bool {
        let number = self.carRepairDetails.phoneFormatted?.digits ?? ""
        return PhoneService.canCall(toNumber: number)
    }
    
    var phoneNumber: String {
        return self.carRepairDetails.phoneFormatted?.digits ?? ""
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


