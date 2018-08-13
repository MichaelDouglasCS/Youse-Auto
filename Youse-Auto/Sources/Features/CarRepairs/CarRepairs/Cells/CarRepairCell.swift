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
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewModel: CarRepairCellViewModel!

    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setup(with viewModel: CarRepairCellViewModel) {
        self.viewModel = viewModel
        
        if let imageURL = self.viewModel.imageURL {
            self.customImageView.load(from: imageURL)
        }
        
        self.nameLabel.text = self.viewModel.name
        self.ratingLabel.text = self.viewModel.rating
        self.addressLabel.text = self.viewModel.address
    }
}
