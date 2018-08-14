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
    
    @IBOutlet weak private var customImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak var ratingView: UIStackView!
    @IBOutlet weak private var ratingLabel: UILabel!
    @IBOutlet weak private var ratingStarsView: CosmosView!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var availabilityLabel: UILabel!

    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setup(with viewModel: CarRepairCellViewModel) {
        self.customImageView.image = UIImage.YouseAuto.carRepairPlaceholder
        self.nameLabel.text = viewModel.name
        self.ratingLabel.text = viewModel.rating?.toString(withDecimalPlaces: 1)
        self.ratingStarsView.rating = viewModel.rating ?? 0.0
        self.ratingView.isHidden = viewModel.rating == nil
        self.addressLabel.attributedText = viewModel.address
        self.availabilityLabel.attributedText = viewModel.availability
        
        if let imageURL = viewModel.imageURL {
            self.customImageView.load(from: imageURL,
                                      withPlaceholder: UIImage.YouseAuto.carRepairPlaceholder)
        }
    }
}
