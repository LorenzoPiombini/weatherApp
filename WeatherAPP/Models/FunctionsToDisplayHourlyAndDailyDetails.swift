//
//  FunctionsToDisplayHourlyAndDailyDetails.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/6/21.
//

import Foundation
import UIKit
class tableView: UITableViewCell{
func updateView(with ApiResponseHourly: Hourly?, ApiResponseDaily: Daily?){
    if let hourly = ApiResponseHourly {
        self.textLabel!.text = "Now is "
        self.detailTextLabel!.text = "\(hourly.weather[0].description)"
        self.textLabel!.text = "Feels Like"
        self.detailTextLabel!.text = "\(convertDegrees(degreese: hourly.feels_like, celsiusTouchInside: celsius))°"
        self.textLabel!.text = "Humidity"
        self.detailTextLabel!.text = "\(hourly.humidity)%"
        self.textLabel!.text = "Wind Speed "
        self.detailTextLabel!.text = "\((Int((hourly.wind_speed) * 2.24))) mph"
        
        self.textLabel!.text = "Pressure"
        self.detailTextLabel!.text = "\(Int(Double((hourly.pressure)) / 1013.25 )) inHg"
        self.textLabel!.text = "Visibility "
        self.detailTextLabel!.text = "\(Int(Double((hourly.visibility!)) * 0.000621371)) mi"
        self.textLabel!.text = "Chance Of Precipitations"
        self.detailTextLabel!.text = "\(Int((hourly.pop) * 100))%"
        self.textLabel!.text = "UVI index"
        self.detailTextLabel!.text = "\(hourly.uvi)"
    } else if let daily = ApiResponseDaily {
        self.textLabel!.text = "\(dayFormatter(fromDayTime: daily)) will be "
        self.detailTextLabel!.text = "\(daily.weather[0].description)"
        self.textLabel!.text = "Feels Like"
        self.detailTextLabel!.text = "\(convertDegrees(degreese: daily.feels_like.day, celsiusTouchInside: celsius))°"
//        minTemp!.text = "\(convertDegrees(degreese: daily.temp.min, celsiusTouchInside: celsius))"
//        maxTemp!.text = "\(convertDegrees(degreese: daily.temp.max, celsiusTouchInside: celsius))"
//        sunriseLbl!.text = ""
//        Sunset!.text = ""
//        humidityLbl.text = "\(daily.humidity)%"
//        windSpeedLbl.text = "\(Int((daily.wind_speed) * 2.24)) mph"
//        pressureLbl.text = "\(Int(Double((daily.pressure)) / 1013.25 )) inHg"
//        if let visibility = daily.visibility {
//        visibilityLbl.text = "\(Int(Double((visibility)) * 0.000621371)) mi"
//        }else {
//            visibilityLbl.text = ""
//        }
//        probailityOfPrecipitationLbl.text = "\(Int((daily.pop) * 100))%"
//        uvilbl.text = "\(daily.uvi)"
 
    }
    
}
}
