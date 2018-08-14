//
//  UITableView+Placeholder.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

extension UITableView {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupPlaceholder(image: UIImage?, title: String? = nil, message: String) {
        
        if let topMostViewController = UIApplication.shared.topMostViewController() {
            let frame = topMostViewController.view.frame
            let placeholder = PlaceholderView(frame: CGRect(x: frame.origin.x,
                                                            y: frame.origin.y,
                                                            width: frame.width,
                                                            height: frame.height))
            let viewModel = PlaceholderViewModel(image: image,
                                                 title: title,
                                                 message: message)
            
            placeholder.setupUI(with: viewModel)
            self.backgroundView = placeholder
        }
    }
}
