//
//  CoreLocationManager.swift
//  Lab
//
//  Created by  on 4/1/19.
//  Copyright © 2019 lab. All rights reserved.
//

import CoreLocation

class SKCoreLocationManager: NSObject {
    
    // MARK: - Properties
    private static var location: CLLocation?
    private var completionHandler: ((_ location: CLLocation?, _ error: Error?) -> Void)?
    private let cLLocationManager = CLLocationManager()
    
    // MARK: - Lifecycles
    override init() {
        //Prepare for use
        print("CORELOCATION INIT!")
    }
    
    // MARK: - Function
    static func getLastLocation() -> CLLocation? {
        return location
    }
    
    func getLocation(completionHandler: @escaping ((_ location: CLLocation?, _ error: Error?) -> Void)) {
        cLLocationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .denied {
            let errorCase: Error = SKGetLocationError.permissionError
            completionHandler(nil, errorCase)
            return
        }
        cLLocationManager.delegate = self
        self.completionHandler = completionHandler
        cLLocationManager.requestLocation()
    }
}

// MARK: -
extension SKCoreLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            SKCoreLocationManager.location = location
            guard let completionHandler = self.completionHandler else { return }
            completionHandler(location, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let completionHandler = self.completionHandler else { return }
        completionHandler(nil, error)
    }
}
