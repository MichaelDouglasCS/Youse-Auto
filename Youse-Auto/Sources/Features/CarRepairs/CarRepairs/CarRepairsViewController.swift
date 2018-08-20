//
//  CarRepairsViewController.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 12/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit
import CoreLocation

class CarRepairsViewController: UIViewController {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet private weak var tableView: UITableView!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    private(set) var viewModel: CarRepairsViewModel!

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
        
        // Inject VM
        self.setupUI(with: CarRepairsViewModel(provider: CarRepairsProvider()))
        
        // Navigation
        self.navigationItem.title = self.viewModel.navigationTitle
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .done,
                                                                target: nil,
                                                                action: nil)
        
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
        
        // Verify Location
        if LocationService.isEnabled {
            // Load Data
            self.showLoading()
            self.loadData {
                self.stopLoading()
            }
        } else {
            // Show Location View Controller
            self.performSegue(withIdentifier: "LocationSegue", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let carRepairDetails = segue.destination as? CarRepairDetailsViewController,
            let index = sender as? Int {
            let provider = CarRepairDetailsProvider()
            let placeID = self.viewModel.placeID(at: index)
            let viewModel = CarRepairDetailsViewModel(provider: provider, placeID: placeID)
            carRepairDetails.setupUI(with: viewModel)
        } else if let location = segue.destination as? LocationViewController {
            location.delegate = self
            location.setupUI(with: LocationViewModel())
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: CarRepairsViewModel) {
        self.viewModel = viewModel
    }
    
    func loadData(completion: @escaping () -> Void) {
        self.viewModel.loadData(type: .refresh) { (error) in
            
            if let error = error {
                self.showInfoAlert(title: String.YouseAuto.oops, message: error)
            }
            self.tableView.placeholder(isShow: error != nil, animate: true)
            self.tableView.reloadSections([0], with: .automatic)
            completion()
        }
    }
    
    func bringMoreData(completion: @escaping () -> Void) {
        self.viewModel.loadData(type: .bringMore) { (error) in

            if let error = error {
                self.showInfoAlert(title: String.YouseAuto.oops, message: error)
            }
            self.tableView.placeholder(isShow: error != nil, animate: true)
            self.tableView.reloadData()
            completion()
        }
    }
    
    @objc func refreshData() {
        self.loadData {
            self.refreshControl.endRefreshing()
        }
    }
}

//*************************************************
// MARK: - UITableViewDataSource
//*************************************************

extension CarRepairsViewController: UITableViewDataSource {

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
        
        if lastRowIndex == indexPath.row &&
            self.viewModel.hasNextPage &&
            !self.viewModel.isLoading {
            
            self.loadingPagination.startAnimating()
            self.bringMoreData {
                self.loadingPagination.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.performSegue(withIdentifier: "CarRepairDetailsSegue", sender: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, options: .allowUserInteraction, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            UIView.animate(withDuration: 0.4, delay: 0.05, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, options: .allowUserInteraction, animations: {
                cell.transform = .identity
            })
        }
    }
}

//*************************************************
// MARK: - UITableViewPlaceholderDelegate
//*************************************************

extension CarRepairsViewController: UITableViewPlaceholderDelegate {
    
    func placeholderViewModel(in tableView: UITableView) -> PlaceholderViewModel {
        return PlaceholderViewModel(image: UIImage.YouseAuto.carOil,
                                    title: String.YouseAuto.sorry,
                                    message: String.YouseAuto.noResultsFound)
    }
}

//*************************************************
// MARK: - LocationViewControllerDelegate
//*************************************************

extension CarRepairsViewController: LocationViewControllerDelegate {
    
    func didGetLocation(location: CLLocation) {
        self.showLoading()
        self.loadData {
            self.stopLoading()
        }
    }
}
