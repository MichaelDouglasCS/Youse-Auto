//
//  UIApplication+Style.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

extension UIApplication {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var topMostViewController: UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController
    }
}

