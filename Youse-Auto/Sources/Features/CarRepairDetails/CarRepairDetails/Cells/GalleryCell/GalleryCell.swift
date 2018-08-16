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
    @IBOutlet private weak var pageLabel: UILabel!
    
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
        self.collectionView.reloadData()
        self.updatePageNumber()
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func updatePageNumber() {
        let x = self.collectionView.contentOffset.x
        let width = self.collectionView.bounds.size.width
        let currentPage = Int(ceil(x / width))
        
        self.pageLabel.text = self.viewModel.pageTitle(forCurrentPage: currentPage)
    }
}

//*************************************************
// MARK: - UICollectionViewDataSource
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

//*************************************************
// MARK: - UICollectionViewDelegateFlowLayout
//*************************************************

extension GalleryCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.sizeForItem(at: indexPath, from: collectionView)
    }
}

//*************************************************
// MARK: - UICollectionViewDelegate
//*************************************************

extension GalleryCell: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.updatePageNumber()
    }
}
