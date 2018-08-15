//
//  Period.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import SwiftyJSON

struct Period {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var weekDay: Int
    var openTime: String
    var closeTime: String
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init?(json: JSON) {
        
        if let weekDay = json["open"]["day"].int ?? json["close"]["day"].int,
            let openTime = json["open"]["time"].string,
            let closeTime = json["close"]["time"].string {
            self.weekDay = weekDay
            self.openTime = openTime
            self.closeTime = closeTime
        } else {
            return nil
        }
    }
}
