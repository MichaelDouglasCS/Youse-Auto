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
    // MARK: - Public Properties
    //*************************************************
    
    var viewModel: CarRepairDetailsViewModel!
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Controller
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.setStatusBarBackground(UIColor.YouseAuto.blue)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Navigation Controller
        self.navigationController?.hidesBarsOnSwipe = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

//*************************************************
// MARK: - UITableViewDataSource
//*************************************************

extension CarRepairDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Teste")
        cell.backgroundColor = .black
        return cell
    }
}

//*************************************************
// MARK: - UITableViewDelegate
//*************************************************

extension CarRepairDetailsViewController: UITableViewDelegate {

}
