//
//  CarRepairDetails.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import SwiftyJSON

struct CarRepairDetails {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var id: String?
    var placeID: String
    var name: String
    var rating: Double?
    var location: Location?
    var address: String?
    var formattedPhone: String?
    var internationalPhone: String?
    var isOpenNow: Bool?
    var periods: [Period]?
    var openingHours: [String]?
    var images: [Photo]?
    var reviews: [Review]?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init?(json: JSON) {
        guard let placeID = json["place_id"].string, !placeID.isEmpty else { return nil }
        guard let name = json["name"].string, !name.isEmpty else { return nil }
        
        self.id = json["id"].string
        self.placeID = placeID
        self.name = name
        self.rating = json["rating"].double
        self.location = Location(json: json["geometry"])
        self.address = json["formatted_address"].string
        self.formattedPhone = json["formatted_phone_number"].string
        self.internationalPhone = json["international_phone_number"].string
        self.isOpenNow = json["opening_hours"]["open_now"].bool
        
        if let periods = json["opening_hours"]["periods"].array {
            self.periods = periods.compactMap { Period(json: $0) }
        }
        
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
