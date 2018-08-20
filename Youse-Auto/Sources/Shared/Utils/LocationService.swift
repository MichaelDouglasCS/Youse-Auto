//
//  LocationService.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 16/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import MapKit

class LocationService: NSObject {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    static let shared: LocationService = LocationService()
    
    static var isEnabled: Bool {
        
        if CLLocationManager.locationServicesEnabled() &&
            !ProcessInfo.processInfo.arguments.contains(Constants.testLocationError) {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                return false
            }
        } else {
            return false
        }
    }
    
    private(set) var lastLocation: CLLocation?

    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var locationManager = CLLocationManager()
    private var success: ((CLLocation) -> Void)?
    private var error: ((String?) -> Void)?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    deinit {
        self.locationManager.stopUpdatingLocation()
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func requestAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func getLocation(success: @escaping ((CLLocation) -> Void),
                     error: ((String?) -> Void)? = nil) {
        let arguments = ProcessInfo.processInfo.arguments
        
        if arguments.contains(Constants.testLocationSuccess) {
            success(CLLocation(latitude: -23.5941355, longitude: -46.6802735))
            return
        } else if arguments.contains(Constants.testLocationError) {
            error?(String.YouseAuto.locationError)
            return
        }
        
        if let lastLocation = self.lastLocation {
            success(lastLocation)
        } else if !LocationService.isEnabled {
            error?(String.YouseAuto.locationError)
        } else {
            self.success = success
            self.error = error
        }
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func resetCompletions() {
        self.success = nil
        self.error = nil
    }
}

//*************************************************
// MARK: - CLLocationManagerDelegate
//*************************************************

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last ?? self.lastLocation {
            self.lastLocation = location
            self.success?(location)
            self.resetCompletions()
        } else {
            self.error?(String.YouseAuto.locationError)
            self.resetCompletions()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.error?(String.YouseAuto.locationError)
        self.resetCompletions()
    }
}
