//
//  GalleryCollectionCell.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class GalleryCollectionCell: UICollectionViewCell {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet weak var imageView: UIImageView!
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: GalleryCollectionCellViewModel) {
        
        if let imageURL = viewModel.url {
            self.imageView.load(from: imageURL,
                                      withPlaceholder: UIImage.YouseAuto.carRepairCover)
        } else {
            self.imageView.image = UIImage.YouseAuto.carRepairCover
        }
    }
}
