//
//  UIImageView+Service.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 13/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import AlamofireImage

extension UIImageView {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func load(from url: URL,
                     withPlaceholder placeholder: UIImage? = nil,
                     completion: ((_ image: UIImage?) -> Void)? = nil ) {
        self.af_setImage(withURL: url,
                         placeholderImage: placeholder,
                         imageTransition: .crossDissolve(0.25)) { [weak self] (dataResponse) in
                            
                            if let theImage = dataResponse.result.value {
                                self?.image = theImage
                            } else if let data = dataResponse.data, let theImage = UIImage(data: data) {
                                self?.image = theImage
                            } else {
                                self?.image = placeholder
                            }
                            
                            completion?(self?.image)
        }
    }
}
