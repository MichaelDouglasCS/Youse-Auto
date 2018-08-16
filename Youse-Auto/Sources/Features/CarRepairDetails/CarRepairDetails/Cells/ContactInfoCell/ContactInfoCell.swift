//
//  ContactInfoCell.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class ContactInfoCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: ContactInfoCellViewModel) {
        self.iconImageView.image = viewModel.icon
        self.contentLabel.isHidden = viewModel.content == nil
        self.contentLabel.text = viewModel.content
        
        if let attributedTitle = viewModel.attributedTitle {
            self.titleLabel.attributedText = attributedTitle
        } else {
            self.titleLabel.text = viewModel.title
        }
    }
}
