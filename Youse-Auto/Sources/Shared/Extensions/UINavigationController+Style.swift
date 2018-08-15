//
//  UINavigationController+Style.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    /// This method is used to change Status Bar background color
    ///
    /// - Parameter color: Set Color, default nil uses navigation bar tint color
    func setStatusBarBackground(_ color: UIColor? = nil) {
        
        if UIApplication.shared.responds(to: Selector(("statusBar"))) {
            let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView
            statusBar?.backgroundColor = color ?? self.navigationBar.barTintColor
        }
    }
}
