//
//  DirectionsService.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit
import MapKit

struct DirectionsService {

	enum Navigator {
		
		case urlScheme(AppInfo)
		
		typealias AppInfo = (name: String, url: String, path: String)
		
		struct App {
			static let apple = Navigator.urlScheme((name: "Apple Maps", url: "http://maps.apple.com/", path: "?daddr="))
			static let googleMaps = Navigator.urlScheme((name: "Google Maps", url: "http://maps.google.com/maps/", path: "?daddr="))
			
			static let all = [apple, googleMaps]
		}
        
        //*************************************************
        // MARK: - Public Properties
        //*************************************************
		
		var name: String {
			switch self {
			case .urlScheme(let name, _, _):
				return name
			}
		}
		
		var canOpenUrl: Bool {
			switch self {
			case .urlScheme(_, let url, _):
                
				if let url = URL(string: url) {
					return UIApplication.shared.canOpenURL(url)
                } else {
                    return false
                }
			}
        }
        
        //*************************************************
        // MARK: - Public Methods
        //*************************************************
        
        func openDirections(fromAddress address: String) {
            switch self {
            case .urlScheme(_, let url, let path):
                let encoded = address.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
                
                if let url = URL(string: url + path + encoded) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************

    /// Shows an action sheet to present the options to the user and then opens the selected map app.
    ///
    /// - Parameters:
    ///   - target: The target view controller in which the image picker will be presented.
    ///   - address: The address string that will be used by the maps app.
    static func presentOptions(fromAddress address: String,
                               at target: UIViewController) {
        let options = DirectionsService.Navigator.App.all
        let actionSheet = UIAlertController(title: nil,
											message: String.YouseAuto.directionsSource,
											preferredStyle: .actionSheet)
		
        options.forEach { (option) in
            
            if option.canOpenUrl {
                let action = UIAlertAction(title: option.name, style: .default) { (_) in
                    option.openDirections(fromAddress: address)
                }
                actionSheet.addAction(action)
            }
        }
		
		if !actionSheet.actions.isEmpty {
			let cancel = UIAlertAction(title: String.YouseAuto.cancel, style: .cancel)
			actionSheet.addAction(cancel)
			
			DispatchQueue.main.async {
				target.present(actionSheet, animated: true)
			}
		} else {
			let noActionAlert = UIAlertController(title: String.YouseAuto.oops,
												  message: String.YouseAuto.noDirections,
												  preferredStyle: .alert)
			let ok = UIAlertAction(title: String.YouseAuto.ok, style: .cancel)
			noActionAlert.addAction(ok)
			
			DispatchQueue.main.async {
				target.present(noActionAlert, animated: true)
			}
		}
	}
}
