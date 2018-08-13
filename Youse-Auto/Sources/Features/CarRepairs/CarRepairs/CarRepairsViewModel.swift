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
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var provider: CarRepairsProvider
    private var nextPage: String?
    private var carRepairs: [CarRepair] = []
    
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
    /// - Parameter completion: This method produces (isSuccess: Bool, localizedError: String?) -> Void
    func loadCarRepairs(completion: @escaping (_ isSuccess: Bool, _ error: String?) -> Void) {
        let location = CLLocation(latitude: -23.5941355, longitude: -46.6802735)
        
        self.provider.loadCarRepairs(by: location) { (carRepairs, nextPage, localizedError) in
            self.carRepairs = carRepairs
            self.nextPage = nextPage
            completion(localizedError == nil, localizedError)
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return self.carRepairs.count
    }
    
    func cellForRow(at indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CarRepairCell")
        cell.textLabel?.text = self.carRepairs[indexPath.row].name
        return cell
    }
}
