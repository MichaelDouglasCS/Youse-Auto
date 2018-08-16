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
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation
        self.navigationItem.title = self.viewModel.navigationTitle
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.setStatusBarBackground(UIColor.YouseAuto.blue)
        
        // Load Data
        self.viewModel.loadData { (error) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Navigation Controller
        self.navigationController?.hidesBarsOnSwipe = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: CarRepairDetailsViewModel) {
        self.viewModel = viewModel
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(at: indexPath)
    }
}
