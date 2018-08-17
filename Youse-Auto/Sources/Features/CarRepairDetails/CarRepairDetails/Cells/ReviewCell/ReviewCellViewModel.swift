//
//  ReviewCellViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

struct ReviewCellViewModel: CarRepairDetailsCellProtocol {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var section: CarRepairDetailsViewModel.Sections {
        return .reviews
    }
    
    var height: CGFloat {
        return UITableViewAutomaticDimension
    }
    
    var authorName: String
    var authorPhotoURL: URL?
    var rating: Double
    var text: String
    var timeDescription: String?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(review: Review) {
        self.authorName = review.authorName
        self.authorPhotoURL = review.authorPhotoURL
        self.rating = review.rating
        self.text = review.text
        self.timeDescription = review.timeDescription
    }
}
