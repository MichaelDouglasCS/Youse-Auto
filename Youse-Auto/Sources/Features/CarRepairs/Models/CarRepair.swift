//
//  CarRepair.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 12/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import SwiftyJSON
import CoreLocation

class CarRepair {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var id: String?
    var placeID: String
    var name: String
    var rating: Double?
    var location: CLLocation?
    var address: String
    var isOpenNow: Bool?
    var isOpenFormatted: NSAttributedString?
    var image: Photo?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init?(json: JSON) {
        guard let placeID = json["place_id"].string, !placeID.isEmpty else { return nil }
        guard let name = json["name"].string, !name.isEmpty else { return nil }
        guard let address = json["vicinity"].string, !address.isEmpty else { return nil }
        
        self.id = json["id"].string
        self.placeID = placeID
        self.name = name
        self.rating = json["rating"].double
        self.address = address
        self.isOpenNow = json["opening_hours"]["open_now"].bool
        
        if let latitude = json["geometry"]["location"]["lat"].double,
            let longitude = json["geometry"]["location"]["lng"].double {
            self.location = CLLocation(latitude: latitude, longitude: longitude)
        }
        
        if let isOpenNow = self.isOpenNow {
            let title: String = isOpenNow ? String.YouseAuto.open : String.YouseAuto.closed
            let color: UIColor = isOpenNow ? UIColor.YouseAuto.green : UIColor.YouseAuto.red
            let font = UIFont.boldSystemFont(ofSize: 12)
            
            self.isOpenFormatted = NSMutableAttributedString(string: title, attributes: [.foregroundColor: color, .font: font])
        }
        
        if let photoJSON = json["photos"].array?.first {
            self.image = Photo(json: photoJSON)
        }
    }
}
