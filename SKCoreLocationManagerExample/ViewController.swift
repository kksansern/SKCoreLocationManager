//
//  ViewController.swift
//  Lab
//
//  Created by  on 4/1/19.
//  Copyright © 2019 lab. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let CLLM = CLLocationManager()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var latitude: String = ""
    var longtitude: String = ""
    let clm = SKCoreLocationManager()
    
    @IBAction func getLocation() {
       setTextOnScreen(latitude: "Loading..",
                       longtitude: "Loading..",
                       errorMessage: "")
        clm.getLocation { [weak self] (location, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.setTextOnScreen(latitude: "LOAD FAIL!",
                                           longtitude: "LOAD FAIL!",
                                           errorMessage: error.localizedDescription)
                return
            }
            guard let location = location else { return }
            strongSelf.latitude = String(location.coordinate.latitude)
            strongSelf.longtitude = String(location.coordinate.latitude)
            strongSelf.setTextOnScreen(latitude: String(location.coordinate.latitude),
                                       longtitude: String(location.coordinate.longitude),
                                       errorMessage: "")
        }
    }
    
    @IBAction func getLastLocation() {
        guard let lastLocation = SKCoreLocationManager.getLastLocation() else { return }
        latitudeLabel.text = String(lastLocation.coordinate.latitude)
        longtitudeLabel.text = String(lastLocation.coordinate.longitude)
    }
    
    func setTextOnScreen(latitude: String,
                         longtitude: String,
                         errorMessage: String) {
        latitudeLabel.text = latitude
        longtitudeLabel.text = longtitude
        errorMessageLabel.text = errorMessage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextOnScreen(latitude: "NO DATA",
                        longtitude: "NO DATA",
                        errorMessage: "")
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.latitude = String(location.coordinate.latitude)
            self.longtitude = String(location.coordinate.latitude)
            self.setTextOnScreen(latitude: String(location.coordinate.latitude),
                                 longtitude: String(location.coordinate.longitude),
                                 errorMessage: "")
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        self.latitudeLabel.text = "LOAD FAIL!"
        self.longtitudeLabel.text = "LOAD FAIL!"
        errorMessageLabel.text = error.localizedDescription
    }
}


