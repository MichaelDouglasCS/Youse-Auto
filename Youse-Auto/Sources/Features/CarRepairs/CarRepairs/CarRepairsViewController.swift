//
//  CarRepairsViewController.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 12/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class CarRepairsViewController: UIViewController {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet private weak var tableView: UITableView!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewModel: CarRepairsViewModel!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let refreshControl = UIRefreshControl()
    private let loadingPagination = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inject Self VM
        self.viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        
        // Navigation
        self.navigationItem.title = self.viewModel.navigationTitle
        
        // Table View
        self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.tableView.placeholderDelegate = self
        self.tableView.placeholder(isShow: false)
        
        // Refresh Control
        self.refreshControl.tintColor = .white
        self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        // Loading Pagination
        self.loadingPagination.color = UIColor.YouseAuto.blue
        
        // Load Data
        self.showLoading()
        self.loadData {
            self.stopLoading()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carRepairDetails = segue.destination as? CarRepairDetailsViewController,
            let index = sender as? Int {
            let placeID = self.viewModel.placeID(at: index)
            let provider = CarRepairDetailsProvider()
            carRepairDetails.viewModel = CarRepairDetailsViewModel(provider: provider,
                                                                   placeID: placeID)
        }
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func loadData(completion: @escaping () -> Void) {
        self.viewModel.loadData(type: .refresh) { (error) in
            
            if let error = error {
                self.showInfoAlert(title: String.YouseAuto.oops, message: error)
            }

            self.tableView.placeholder(isShow: error != nil, animate: true)
            self.tableView.reloadSections([0], with: .automatic)
            completion()
        }
    }
    
    private func bringMoreData(completion: @escaping () -> Void) {
        self.viewModel.loadData(type: .bringMore) { (error) in

            if let error = error {
                self.showInfoAlert(title: String.YouseAuto.oops, message: error)
            }
            self.tableView.placeholder(isShow: error != nil, animate: true)
            self.tableView.reloadData()
            completion()
        }
    }
    
    @objc private func refreshData() {
        self.loadData {
            self.refreshControl.endRefreshing()
        }
    }
}

//*************************************************
// MARK: - UITableViewDataSource
//*************************************************

extension CarRepairsViewController: UITableViewDataSource {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.cellForRow(at: indexPath, from: tableView)
    }
}

//*************************************************
// MARK: - UITableViewDelegate
//*************************************************

extension CarRepairsViewController: UITableViewDelegate {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewModel.hasNextPage ? self.loadingPagination : nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.viewModel.hasNextPage ? 44.0 : 0.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if lastRowIndex == indexPath.row && self.viewModel.hasNextPage {
            self.loadingPagination.startAnimating()
            self.bringMoreData {
                self.loadingPagination.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CarRepairDetailsSegue", sender: indexPath.row)
    }
}

//*************************************************
// MARK: - UITableViewPlaceholderDelegate
//*************************************************

extension CarRepairsViewController: UITableViewPlaceholderDelegate {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func placeholderViewModel(in tableView: UITableView) -> PlaceholderViewModel {
        return PlaceholderViewModel(image: UIImage.YouseAuto.carRepairOil,
                                    title: String.YouseAuto.sorry,
                                    message: String.YouseAuto.noResultsFound)
    }
}
