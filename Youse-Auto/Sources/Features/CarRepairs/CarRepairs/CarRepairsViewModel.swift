//
//  CarRepairsViewModel.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 12/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit
import CoreLocation

class CarRepairsViewModel: NSObject {
    
    enum LoadDataType {
        case refresh
        case bringMore
    }
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var navigationTitle: String {
        return String.YouseAuto.carRepairs
    }
    
    var hasNextPage: Bool {
        return self.nextPage != nil && !self.cellViewModels.isEmpty
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var provider: CarRepairsProvider
    private var nextPage: String?
    private var cellViewModels: [CarRepairCellViewModel] = []
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(provider: CarRepairsProvider) {
        self.provider = provider
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return self.cellViewModels.count
    }
    
    func cellForRow(at indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarRepairCell.self), for: indexPath) as? CarRepairCell {
            cell.setupUI(with: self.cellViewModels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return self.cellViewModels[indexPath.row].height
    }
    
    func placeID(at index: Int) -> String {
        return self.cellViewModels[index].placeID
    }
    
    /// This method is used to load a list of Car Repairs
    ///
    /// - Parameters:
    ///   - type: A property to set what kind of request will be performed
    ///   - completion: This parameter produces (error: String?) -> Void
    func loadData(type: LoadDataType, completion: @escaping (_ error: String?) -> Void) {
        let location = CLLocation(latitude: -23.5941355, longitude: -46.6802735)
        let nextPage = type == .refresh ? nil : self.nextPage
        
        self.provider.carRepairs(by: location,
                                 nextPage: nextPage) { (carRepairs, nextPage, error) in
            var cellViewModels: [CarRepairCellViewModel] = []
            
            carRepairs.forEach { cellViewModels.append(CarRepairCellViewModel(carRepair: $0)) }
            
            switch type {
            case .refresh:
                if !cellViewModels.isEmpty {
                    self.cellViewModels = cellViewModels
                }
            case .bringMore:
                self.cellViewModels.append(contentsOf: cellViewModels)
            }
            self.nextPage = nextPage
            completion(error)
        }
    }
}
