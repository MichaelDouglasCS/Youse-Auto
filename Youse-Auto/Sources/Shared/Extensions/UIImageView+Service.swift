//
//  UIImageView+Service.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 13/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

extension UIImageView {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func load(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        
        DispatchQueue.global().async { [weak self] in
            
            if let data = try? Data(contentsOf: url) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
