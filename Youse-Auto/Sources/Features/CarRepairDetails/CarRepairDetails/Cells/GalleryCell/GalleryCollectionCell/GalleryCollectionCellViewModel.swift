//
//  GalleryCollectionCellViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

struct GalleryCollectionCellViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var url: URL?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(image: Photo) {
        self.url = image.url
    }
}
