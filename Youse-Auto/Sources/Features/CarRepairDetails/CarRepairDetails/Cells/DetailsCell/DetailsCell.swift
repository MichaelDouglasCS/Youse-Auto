//
//  DetailsCell.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

protocol DetailsCellDelegate: class {
    func didTouchCall(toNumber number: String)
    func didTouchGetDirections(fromAddress address: String)
}

class DetailsCell: UITableViewCell {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingView: UIStackView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingStars: CosmosView!
    @IBOutlet private weak var distanceView: UIStackView!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var availabilityLabel: UILabel!
    @IBOutlet private weak var callButton: CustomButton!
    @IBOutlet private weak var directionsButton: CustomButton!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    weak var delegate: DetailsCellDelegate?
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var viewModel: DetailsCellViewModel!
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: DetailsCellViewModel) {
        self.viewModel = viewModel
        self.nameLabel.text = self.viewModel.name
        self.availabilityLabel.attributedText = self.viewModel.availability
        
        self.ratingView.isHidden = self.viewModel.rating == nil
        self.ratingLabel.text = self.viewModel.rating?.toString(withDecimalPlaces: 1)
        self.ratingStars.rating = self.viewModel.rating ?? 0.0
        
        self.distanceView.isHidden = self.viewModel.distance == nil
        self.distanceLabel.text = self.viewModel.distance
        
        self.callButton.setTitle(String.YouseAuto.call, for: .normal)
        self.callButton.isHidden = !self.viewModel.hasPhone
        
        self.directionsButton.setTitle(String.YouseAuto.directions, for: .normal)
        self.directionsButton.isHidden = !self.viewModel.hasDirections
    }
    
    //*************************************************
    // MARK: - Actions
    //*************************************************
    
    @IBAction func call(_ sender: CustomButton) {
        self.delegate?.didTouchCall(toNumber: self.viewModel.phoneNumber)
    }
    
    @IBAction func directions(_ sender: CustomButton) {
        self.delegate?.didTouchGetDirections(fromAddress: self.viewModel.address)
    }
}
