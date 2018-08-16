//
//  CarRepairDetailsViewController.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 14/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class CarRepairDetailsViewController: UIViewController {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet private weak var tableView: UITableView!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var viewModel: CarRepairDetailsViewModel!
    private let refreshControl = UIRefreshControl()
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation
        self.navigationItem.title = self.viewModel.navigationTitle
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.setStatusBarBackground(UIColor.YouseAuto.blue)
        
        // Table View
        self.tableView.placeholderDelegate = self
        self.tableView.placeholder(isShow: false)
        
        // Refresh Control
        self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        // Load Data
        self.showLoading()
        self.loadData {
            self.stopLoading()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Navigation
        self.navigationController?.hidesBarsOnSwipe = false
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: CarRepairDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func loadData(completion: @escaping () -> Void) {
        
        self.viewModel.loadData { (error) in
            
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

extension CarRepairDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.cellForRow(at: indexPath, from: tableView)
    }
}

//*************************************************
// MARK: - UITableViewDelegate
//*************************************************

extension CarRepairDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewModel.heightForHeader(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.titleForHeader(inSection: section)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(at: indexPath)
    }
}

//*************************************************
// MARK: - UITableViewPlaceholderDelegate
//*************************************************

extension CarRepairDetailsViewController: UITableViewPlaceholderDelegate {
    
    func placeholderViewModel(in tableView: UITableView) -> PlaceholderViewModel {
        return PlaceholderViewModel(image: UIImage.YouseAuto.carRepairDetails,
                                    title: String.YouseAuto.sorry,
                                    message: String.YouseAuto.noDetailsLoad)
    }
}
