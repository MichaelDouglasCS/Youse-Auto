//
//  ContactInfoCellViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

struct ContactInfoCellViewModel: CarRepairDetailsCellProtocol {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var section: CarRepairDetailsViewModel.Sections {
        return .contactInfo
    }
    
    var height: CGFloat {
        return UITableViewAutomaticDimension
    }
    
    var icon: UIImage
    var title: String
    var attributedTitle: NSAttributedString?
    var content: String?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(icon: UIImage,
         title: String,
         attributedTitle: NSAttributedString? = nil,
         content: String? = nil) {
        self.icon = icon
        self.title = title
        self.attributedTitle = attributedTitle
        self.content = content
    }
}
