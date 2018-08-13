//
//  Photo.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 13/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo: NSObject {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var id: String?
    var height: Int?
    var width: Int?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init?(json: JSON) {
        guard let id = json["photo_reference"].string, !id.isEmpty else { return nil }
        
        self.id = id
        self.height = json["height"].int
        self.width = json["width"].int
    }
}
