//
//  PlaceholderViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class PlaceholderViewModel: NSObject {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var image: UIImage?
    var title: String?
    var message: String
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(image: UIImage?, title: String?, message: String) {
        self.image = image
        self.title = title
        self.message = message
    }
}
