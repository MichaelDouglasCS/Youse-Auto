//
//  Review.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import SwiftyJSON

struct Review {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var authorName: String
    var authorPhotoURL: URL?
    var rating: Double
    var text: String
    var timeDescription: String?
    var time: TimeInterval?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init?(json: JSON) {
        guard let authorName = json["author_name"].string, !authorName.isEmpty else { return nil }
        guard let rating = json["rating"].double else { return nil }
        guard let text = json["text"].string, !text.isEmpty else { return nil }
        
        self.authorName = authorName
        self.authorPhotoURL = json["profile_photo_url"].url
        self.rating = rating
        self.text = text
        self.timeDescription = json["relative_time_description"].string
        self.time = json["time"].double
    }
}
