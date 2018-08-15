//
//  Location.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import SwiftyJSON

struct Location {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var latitude: Double
    var longitude: Double
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init?(json: JSON) {
        
        if let latitude = json["location"]["lat"].double,
            let longitude = json["location"]["lng"].double {
            self.latitude = latitude
            self.longitude = longitude
        } else {
            return nil
        }
    }
}
