//
//  UITableView+Placeholder.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

protocol UITableViewPlaceholderDelegate: class {
    func placeholderViewModel(in tableView: UITableView) -> PlaceholderViewModel
}

extension UITableView {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    weak var placeholderDelegate: UITableViewPlaceholderDelegate? {
        get {
            return self.placeholderDelegate
        }
        set(newValue) {
            if let viewModel = newValue?.placeholderViewModel(in: self) {
                self.setupPlaceholder(with: viewModel)
            }
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func placeholder(isShow: Bool, animate: Bool = false) {
        
        if isShow {
            
            if animate {
                self.backgroundView?.alpha = isShow ? 0.0 : 1.0
                UIView.animate(withDuration: 0.3) {
                    self.backgroundView?.alpha = isShow ? 1.0 : 0.0
                }
            } else {
                self.backgroundView?.alpha = isShow ? 1.0 : 0.0
            }
        } else {
            self.backgroundView?.alpha = isShow ? 1.0 : 0.0
        }
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func setupPlaceholder(with viewModel: PlaceholderViewModel) {
        
        if let topMostViewController = UIApplication.shared.topMostViewController {
            let frame = topMostViewController.view.frame
            let placeholder = PlaceholderView(frame: CGRect(x: frame.origin.x,
                                                            y: frame.origin.y,
                                                            width: frame.width,
                                                            height: frame.height))
            
            placeholder.setupUI(with: viewModel)
            self.backgroundView = placeholder
        }
    }
}
