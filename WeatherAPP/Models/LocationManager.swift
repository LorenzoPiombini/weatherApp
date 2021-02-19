//
//  LocationManager.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 1/31/21.
//

import Foundation
import CoreLocation
import UIKit
struct LocationManager {
   var locationManager = CLLocationManager()
    
    
    //this is the location manager config called in the ViewDidLoad func
    func locationConfing(delegate: UIViewController){
        
        locationManager.delegate = delegate as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    mutating func locationStatus(){
        if locationManager.authorizationStatus != .authorizedAlways {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    // i used this method because it is a way faster than .requestLocation() we the latter the app took a couple o second before loading the location
    func startFindingLocation(){
        locationManager.startUpdatingLocation()
    }
    
    func stopFindngLocation(){
        locationManager.stopUpdatingLocation()
    }
    
    func isFuctionHeadingAvaible(){
        
    }
}
