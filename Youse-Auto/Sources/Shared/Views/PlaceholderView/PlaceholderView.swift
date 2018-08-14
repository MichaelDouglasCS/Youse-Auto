//
//  PlaceholderView.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class PlaceholderView: UIView {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    private func loadNib() {
        Bundle.main.loadNibNamed(String(describing: PlaceholderView.self),
                                 owner: self,
                                 options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.frame
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setupUI(with viewModel: PlaceholderViewModel) {
        self.imageView.image = viewModel.image
        self.imageView.isHidden = viewModel.image == nil
        self.titleLabel.text = viewModel.title
        self.messageLabel.text = viewModel.message
    }
}
