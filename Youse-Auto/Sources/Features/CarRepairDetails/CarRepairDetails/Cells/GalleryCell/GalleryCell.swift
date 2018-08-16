//
//  GalleryCell.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 15/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class GalleryCell: UITableViewCell {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var viewModel: GalleryCellViewModel!
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: GalleryCellViewModel) {
        self.viewModel = viewModel
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

//*************************************************
// MARK: -
//*************************************************

extension GalleryCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.viewModel.cellForItem(at: indexPath, from: collectionView)
    }
}

extension GalleryCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.sizeForItem(at: indexPath, from: collectionView)
    }
}
