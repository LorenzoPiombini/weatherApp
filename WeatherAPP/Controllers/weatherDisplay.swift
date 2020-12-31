//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 12/23/20.
//

import UIKit
import CoreLocation


class weatherDisplay: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    var weathers = Array<apiResponse>()
  
    @IBOutlet weak var locationLbl:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationConfig()
        locationManager.requestLocation()
    }

    
    
    
    
    
    func locationConfig(){
      
       locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let translatorUserFriendly = CLGeocoder()
        let coordinate = locations[0]
       translatorUserFriendly.reverseGeocodeLocation(coordinate) { [self] (placemark: [CLPlacemark]?, error: Error?)->Void in
            
            if placemark!.count > 0 {
                   
                locationLbl.text = "\(placemark![0].locality!)"
                let locationDetected = String.lowercased("\(placemark![0].locality!)")
                Network.shared.location = locationDetected()
                Network.shared.getTheWeather { (apiResponses) in
                    self.weathers = apiResponses.items
                    
                } onError: { (Error) in
                    print(Error)
                }
                } else {
                   print(error!)
                }
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("What is going on ?")
    }
    
   
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        locationManager.requestAlwaysAuthorization()
//    }
 
    
}

