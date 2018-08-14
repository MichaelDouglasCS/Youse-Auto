//
//  UIViewController+Utils.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

//*************************************************
// MARK: - UIViewController
//*************************************************

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
}

//*************************************************
// MARK: - UIApplication
//*************************************************

extension UIApplication {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}
