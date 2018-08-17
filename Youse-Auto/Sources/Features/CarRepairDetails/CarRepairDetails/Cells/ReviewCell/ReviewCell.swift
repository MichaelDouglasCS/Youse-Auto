//
//  ReviewCell.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingStars: CosmosView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: ReviewCellViewModel) {
        self.nameLabel.text = viewModel.authorName
        self.ratingStars.rating = viewModel.rating
        self.timeLabel.isHidden = viewModel.timeDescription == nil
        self.timeLabel.text = viewModel.timeDescription
        self.contentLabel.text = viewModel.text
        
        if let url = viewModel.authorPhotoURL {
            self.profileImageView?.load(from: url,
                                 withPlaceholder: UIImage.YouseAuto.user)
        } else {
            self.profileImageView?.image = UIImage.YouseAuto.user
        }
    }
}
