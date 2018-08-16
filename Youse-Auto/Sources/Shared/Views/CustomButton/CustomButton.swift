//
//  CustomButton.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {

    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    @IBInspectable var cornerRadius: CGFloat = 10 { didSet { self.setup() } }
    @IBInspectable var borderWidth: CGFloat = 0 { didSet { self.setup() } }
    @IBInspectable var borderColor: UIColor? { didSet { self.setup() } }
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setup()
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func setup() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = cornerRadius > 0
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
    }
}
