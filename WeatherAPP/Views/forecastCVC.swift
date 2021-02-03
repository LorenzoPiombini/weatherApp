//
//  forecastCVC.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 1/11/21.
//

import UIKit

class forecastCVC: UICollectionViewCell {
    
    @IBOutlet weak var hourLbl : UILabel!
    @IBOutlet weak var iconWeatherImage: UIImageView!
    @IBOutlet weak var deggreesLbl: UILabel!
    
    
    func updateView(weather: apiResponseForHourForecastinAndDay, indexPath: IndexPath){
        
        hourLbl.text = "\(weather.hourly[indexPath.row].dt)/3600)"
        
    
    
    
}
}
