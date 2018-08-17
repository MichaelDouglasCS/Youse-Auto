//
//  LocationViewController.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit
import MapKit

protocol LocationViewControllerDelegate: class {
    func didGetLocation(location: CLLocation)
}

class LocationViewController: UIViewController {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var continueButton: CustomButton!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    weak var delegate: LocationViewControllerDelegate?
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var viewModel: LocationViewModel!
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update UI
        self.messageLabel.text = self.viewModel.message
        self.continueButton.setTitle(self.viewModel.buttonTitle, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setStatusBarBackground(color: nil, with: .default)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.setStatusBarBackground(color: nil, with: .lightContent)
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func setupUI(with viewModel: LocationViewModel) {
        self.viewModel = viewModel
    }
    
    //*************************************************
    // MARK: - Actions
    //*************************************************
    
    
    @IBAction func continueAction(_ sender: CustomButton) {
        self.viewModel.getLocation { [weak self] (location) in
            
            if let location = location {
                self?.delegate?.didGetLocation(location: location)
                
                DispatchQueue.main.async {
                    self?.dismiss(animated: true)
                }
            } else {
                self?.showInfoAlert(title: String.YouseAuto.sorry,
                                   message: String.YouseAuto.allowLocation)
            }
        }
    }
}
