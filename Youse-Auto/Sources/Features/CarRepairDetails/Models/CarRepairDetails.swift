//
//  CarRepairDetails.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import SwiftyJSON

class CarRepairDetails: CarRepair {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var location: Location?
    var addressFormatted: String?
    var phoneFormatted: String?
    var openingHours: [String]?
    var images: [Photo]?
    var reviews: [Review]?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    override init?(json: JSON) {
        super.init(json: json)
        
        self.location = Location(json: json["geometry"])
        self.addressFormatted = json["formatted_address"].string
        self.phoneFormatted = json["formatted_phone_number"].string
        
        if let openingHours = json["opening_hours"]["weekday_text"].array {
            self.openingHours = openingHours.compactMap { $0.stringValue }
        }
        
        if let images = json["photos"].array {
            self.images = images.compactMap { Photo(json: $0) }
        }
        
        if let reviews = json["reviews"].array {
            self.reviews = reviews.compactMap { Review(json: $0) }
        }
    }
}
