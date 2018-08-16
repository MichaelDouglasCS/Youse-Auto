//
//  GalleryCellViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

struct GalleryCellViewModel: CarRepairDetailsCellProtocol {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var section: CarRepairDetailsViewModel.Sections {
        return .basicInfo
    }
    
    var height: CGFloat {
        return 250.0
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var images: [Photo]
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(images: [Photo]) {
        self.images = images
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return self.images.count
    }
    
    func sizeForItem(at indexPath: IndexPath, from collectionView: UICollectionView) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.height)
    }
    
    func cellForItem(at indexPath: IndexPath,
                     from collectionView: UICollectionView) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GalleryCollectionCell.self), for: indexPath) as? GalleryCollectionCell {
            let viewModel = GalleryCollectionCellViewModel(image: self.images[indexPath.item])
            cell.setupUI(with: viewModel)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func pageTitle(forCurrentPage currentPage: Int) -> String {
        let total = self.images.count
        return "\(currentPage + 1) \(String.YouseAuto.of) \(total)"
    }
}
