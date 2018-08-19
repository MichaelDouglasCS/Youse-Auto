//
//  UIViewController+Alert.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private static func generateAlert(for title: String,
                                      message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alert
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func showInfoAlert(title: String,
                       message: String,
                       completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIViewController.generateAlert(for: title, message: message)
        let defaultAction = UIAlertAction(title: String.YouseAuto.ok,
                                          style: .default,
                                          handler: completion)
        alert.addAction(defaultAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
