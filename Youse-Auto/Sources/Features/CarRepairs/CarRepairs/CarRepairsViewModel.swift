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
        return Constants.carRepairs
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
    
    /// This method is used to load a list of Car Repairs
    ///
    /// - Parameters:
    ///   - type: A property to set what kind of request will be performed
    ///   - completion: This parameter produces (isSuccess: Bool, localizedError: String?) -> Void
    func loadData(type: LoadDataType,completion: @escaping (_ isSuccess: Bool, _ error: String?) -> Void) {
        let location = CLLocation(latitude: -23.5941355, longitude: -46.6802735)
        let nextPage = type == .refresh ? nil : self.nextPage
        
        self.provider.loadCarRepairs(by: location, nextPage: nextPage) { (carRepairs, nextPage, localizedError) in
            var cellViewModels: [CarRepairCellViewModel] = []
            
            carRepairs.forEach({ (carRepair) in
                cellViewModels.append(CarRepairCellViewModel(carRepair: carRepair))
            })
            
            self.nextPage = nextPage
            
            switch type {
            case .refresh:
                self.cellViewModels = cellViewModels
            case .bringMore:
                self.cellViewModels.append(contentsOf: cellViewModels)
            }
            
            completion(localizedError == nil, localizedError)
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return self.cellViewModels.count
    }
    
    func cellForRow(at indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarRepairCell.self)) as? CarRepairCell else { return UITableViewCell() }
        cell.setup(with: self.cellViewModels[indexPath.row])
        return cell
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return self.cellViewModels[indexPath.row].height
    }
}
