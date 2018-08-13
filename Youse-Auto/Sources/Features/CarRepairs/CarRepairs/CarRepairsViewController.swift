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
    
    @IBOutlet weak private var tableView: UITableView!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewModel: CarRepairsViewModel!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let refreshControl = UIRefreshControl()
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()

        // Status Bar Style
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Inject Self VM
        self.viewModel = CarRepairsViewModel(provider: CarRepairsProvider())
        
        // Navigation
        self.navigationItem.title = self.viewModel.navigationTitle
        
        // Setup Refresh Control
        self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
        
        // Load Data
        self.loadData { }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func loadData(completion: @escaping () -> Void) {
        self.viewModel.loadCarRepairs { (isSuccess, error) in
            self.tableView.reloadSections([0], with: .automatic)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(at: indexPath)
    }
}
