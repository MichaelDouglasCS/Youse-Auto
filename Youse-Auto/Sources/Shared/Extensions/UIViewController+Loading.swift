//
//  UIViewController+Style.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func showLoading() {
        
        DispatchQueue.main.async {
            let viewHeight = self.view.frame.height
            let viewWidth = self.view.frame.width
            let indicator = UIActivityIndicatorView()
            
            indicator.activityIndicatorViewStyle = .whiteLarge
            indicator.color = UIColor.YouseAuto.blue
            indicator.center = CGPoint(x: viewWidth / 2, y: viewHeight / 2)
            indicator.startAnimating()
            
            self.view.addSubview(indicator)
        }
    }
    
    func stopLoading() {
        self.view.subviews.forEach({ (view) in
            if let indicator = view as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        })
    }
}
