//
//  CarRepairCell.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 13/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class CarRepairCell: UITableViewCell {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************

    @IBOutlet private weak var customImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingView: UIStackView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingStarsView: CosmosView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var availabilityLabel: UILabel!

    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: CarRepairCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.ratingView.isHidden = viewModel.rating == nil
        self.ratingLabel.text = viewModel.rating?.toString(withDecimalPlaces: 1)
        self.ratingStarsView.rating = viewModel.rating ?? 0.0
        self.addressLabel.attributedText = viewModel.address
        self.availabilityLabel.attributedText = viewModel.availability
        
        if let imageURL = viewModel.imageURL {
            self.customImageView.load(from: imageURL,
                                      withPlaceholder: UIImage.YouseAuto.carRepairCover)
        } else {
            self.customImageView.image = UIImage.YouseAuto.carRepairCover
        }
    }
}
