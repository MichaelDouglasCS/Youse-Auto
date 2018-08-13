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
    /// - Parameter completion: This method produces (isSuccess: Bool, error: String) -> Void
    func loadCarRepairs(completion: @escaping (_ isSuccess: Bool, _ error: String) -> Void) {
        let location = CLLocation(latitude: 37.3330499, longitude: -122.0110933)
        
        self.provider.loadCarRepairs(by: location, nextPage: self.nextPage) { (nextPage, error) in
            self.nextPage = nextPage
            completion(self.nextPage != nil, error ?? "")
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func cellForRow(at indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        return UITableViewCell()
    }
}
