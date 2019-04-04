//
//  CoreLocationManager.swift
//  Lab
//
//  Created by  on 4/1/19.
//  Copyright © 2019 lab. All rights reserved.
//

import CoreLocation

enum SKLocationAccuracy {
    case BestForNavigation
    case Best
    case NearestTenMeters
    case HundredMeters
    case Kilometer
    case ThreeKilometers
}

class SKCoreLocationManager: NSObject {
    
    // MARK: - Properties
    private static var location: CLLocation?
    private var completionHandler: ((_ location: CLLocation?, _ error: Error?) -> Void)?
    private let cLLocationManager = CLLocationManager()
    
    // MARK: - Lifecycles
    override init() {
        //Prepare for use
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
    
    func getLocationLive(desiredAccuracy: SKLocationAccuracy,
                         completionHandler: @escaping ((_ location: CLLocation?, _ error: Error?) -> Void)) {
        cLLocationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .denied {
            let errorCase: Error = SKGetLocationError.permissionError
            completionHandler(nil, errorCase)
            return
        }
        cLLocationManager.delegate = self
        self.completionHandler = completionHandler
        
        switch desiredAccuracy {
        case .BestForNavigation:
            cLLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        case .Best:
            cLLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .NearestTenMeters:
            cLLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        case .HundredMeters:
            cLLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        case .Kilometer:
            cLLocationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        case .ThreeKilometers:
            cLLocationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        }
        
        cLLocationManager.startUpdatingLocation()
    }
    
    
    func stopLocationLive() {
        cLLocationManager.stopUpdatingLocation()
    }
}

// MARK: -
extension SKCoreLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            SKCoreLocationManager.location = location
            //print(location.coordinate.latitude, " - ", location.coordinate.longitude)
            guard let completionHandler = self.completionHandler else { return }
            completionHandler(location, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let completionHandler = self.completionHandler else { return }
        completionHandler(nil, error)
    }
}
