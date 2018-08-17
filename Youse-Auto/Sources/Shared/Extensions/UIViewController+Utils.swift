//
//  UIViewController+Utils.swift
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
    
    func topMostViewController() -> UIViewController {
        
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
    
    /// This method is used to change Status Bar background color
    ///
    /// - Parameter color: Set Color, default nil uses navigation bar tint color
    func setStatusBarBackground(color: UIColor? = nil, with style: UIStatusBarStyle) {
        
        if UIApplication.shared.responds(to: Selector(("statusBar"))),
            let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            let color = color ?? self.navigationController?.navigationBar.barTintColor
            
            UIApplication.shared.statusBarStyle = style
            statusBar.backgroundColor = color
        }
    }
}
