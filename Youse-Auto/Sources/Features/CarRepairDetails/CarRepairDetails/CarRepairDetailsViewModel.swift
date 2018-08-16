//
//  CarRepairDetailsViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class CarRepairDetailsViewModel: NSObject {
    
    enum Sections: Int {
        case basicInfo = 0
        case contactInfo = 1
        case reviews = 2
        
        static var count: Int {
            let sections: [Sections] = [.basicInfo, .contactInfo, .reviews]
            return sections.count
        }
        
        var height: CGFloat {
            switch self {
            case .basicInfo:
                return CGFloat.leastNormalMagnitude
            case .contactInfo:
                return 14.0
            case .reviews:
                return 14.0
            }
        }
        
        var title: String {
            switch self {
            case .basicInfo:
                return ""
            case .contactInfo:
                return String.YouseAuto.informations
            case .reviews:
                return String.YouseAuto.reviews
            }
        }
    }
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var navigationTitle: String {
        return String.YouseAuto.details
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var provider: CarRepairDetailsProvider
    private var placeID: String
    private var cellViewModels: [[CarRepairDetailsCellProtocol]] = []
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(provider: CarRepairDetailsProvider, placeID: String) {
        self.provider = provider
        self.placeID = placeID
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func numberOfSections() -> Int {
        return self.cellViewModels.count
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return self.cellViewModels[section].count
    }
    
    func cellForRow(at indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        let cellViewModel = self.cellViewModels[indexPath.section][indexPath.row]
        
        switch cellViewModel {
        case is GalleryCellViewModel:
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GalleryCell.self)) as? GalleryCell,
                let viewModel = cellViewModel as? GalleryCellViewModel {
                cell.setupUI(with: viewModel)
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func heightForHeader(inSection section: Int) -> CGFloat {
        return self.cellViewModels[section].first?.section.height ?? 0.0
    }
    
    func titleForHeader(inSection section: Int) -> String {
        return self.cellViewModels[section].first?.section.title ?? ""
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return self.cellViewModels[indexPath.section][indexPath.row].height
    }
    
    /// This method is used to load a list of Car Repairs
    ///
    /// - Parameters:
    ///   - type: A property to set what kind of request will be performed
    ///   - completion: This parameter produces (isSuccess: Bool, localizedError: String?) -> Void
    func loadData(completion: @escaping (_ error: String?) -> Void) {
        self.provider.carRepairDetails(byPlaceID: self.placeID) { (carRepairDetails, error) in
            self.handleCellViewModels(with: carRepairDetails)
            completion(error)
        }
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func handleCellViewModels(with carRepairDetails: CarRepairDetails?) {

        if let details = carRepairDetails {
            
            self.cellViewModels = []
            
            //*************************************************
            // MARK: - Basic Info ViewModels
            //*************************************************
            
            var basicInfoViewModels: [CarRepairDetailsCellProtocol] = []
            
            if let images = details.images {
                basicInfoViewModels.append(GalleryCellViewModel(images: images))
            } else {
                basicInfoViewModels.append(GalleryCellViewModel(images: [Photo()]))
            }
            
            self.cellViewModels.append(basicInfoViewModels)
        }
    }
}
