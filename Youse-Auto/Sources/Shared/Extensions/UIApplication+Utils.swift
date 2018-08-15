//
//  UIApplication+Style.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

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

