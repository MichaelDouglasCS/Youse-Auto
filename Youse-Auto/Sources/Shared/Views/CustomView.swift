//
//  CustomView.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 13/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBInspectable var cornerRadius: CGFloat = 10.0
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    @IBInspectable var shadowRadius: CGFloat = 0.0
    @IBInspectable var shadowOpacity: Float = 1.0
    @IBInspectable var shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.lightGray
    @IBInspectable var dashedLine: Int = 0
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var bezierPath: UIBezierPath {
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius)
        return path
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var stroke: CALayer = CALayer()
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func setupView() {
        let path = self.bezierPath
        
        self.layer.cornerRadius = self.cornerRadius
        self.stroke.removeFromSuperlayer()
        
        if self.borderWidth > 0.0 {
            
            if self.dashedLine > 0 {
                let caLayer = self.layer
                let line = CAShapeLayer()
                
                line.frame = self.bounds
                line.strokeColor = self.borderColor.cgColor
                line.lineWidth = self.borderWidth
                line.lineDashPattern = [NSNumber(value: self.dashedLine)]
                line.lineDashPhase = 2.0
                line.path = path.cgPath
                line.fillColor = nil
                self.stroke = line
                
                caLayer.insertSublayer(self.stroke, at: 0)
                caLayer.borderColor = nil
                caLayer.borderWidth = 0
            } else {
                let caLayer = self.layer
                
                caLayer.borderColor = self.borderColor.cgColor
                caLayer.borderWidth = self.borderWidth
            }
        }
        
        if self.shadowRadius > 0.0 || self.shadowOffset != CGSize.zero {
            let shadow = self.layer
            
            shadow.shadowColor = self.shadowColor.cgColor
            shadow.shadowOffset = self.shadowOffset
            shadow.shadowRadius = self.shadowRadius
            shadow.shadowOpacity = self.shadowOpacity
            shadow.shadowPath = path.cgPath
        } else {
            let shadow = self.layer
            
            shadow.shadowColor = nil
            shadow.shadowRadius = 0.0
            shadow.shadowOpacity = 0.0
            shadow.shadowPath = nil
        }
    }
}
