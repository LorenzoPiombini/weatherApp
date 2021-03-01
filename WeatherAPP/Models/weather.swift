//
//  weather.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 12/27/20.
//

import Foundation
import UIKit



// this is the http request used for hour and five days forecast
struct apiResponseForHourForecastinAndDay:Codable {
  var lat: Double
  var lon: Double
  var timezone: String
  var timezone_offset: Int
  var current: Current
    var hourly: [Hourly]
  var daily: [Daily]
}


// sub-objects used to built the two main objects above
//######################################################################################
struct Current:Codable {
  var dt: Int
  var sunrise: Int
  var sunset: Int
  var temp: Double
  var feels_like: Double
  var pressure: Int
  var humidity: Int
  var dew_point: Double
  var uvi: Double
  var clouds: Int
  var visibility: Int?
  var wind_speed: Double
  var wind_deg: Int
  var wind_gust: Double?
  var weather: [Weather]
  
  
}



struct Hourly: Codable {
  var dt: Int
  var temp: Double
  var feels_like: Double
  var pressure: Int
  var humidity: Int
  var dew_point: Double
  var uvi: Double
  var clouds: Int
  var visibility:Int?
  var wind_speed: Double
  var wind_deg: Int
  var weather: [Weather]
  var pop: Double
}
 


struct Daily: Codable {
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: Temp
    var feels_like: FeelsLike
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var clouds: Int
    var visibility:Int?
    var wind_speed: Double
    var wind_deg: Int
    var weather: [Weather]
    var rain: Double?
    var snow: Double?
    var pop: Double
    var uvi: Double
}

struct Temp: Codable {
  var day: Double
  var min: Double
  var max: Double
  var night: Double
  var eve: Double
  var morn: Double
}

struct FeelsLike: Codable {
  var day: Double
  var night: Double
  var eve: Double
  var morn: Double
}



struct Weather: Codable {
    var  id: Int
    var  main: String
    var description: String
    var icon: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case main
        case description
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.main = try valueContainer.decode(String.self, forKey: CodingKeys.main)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.icon = try valueContainer.decode(String.self, forKey: CodingKeys.icon)
    }
}


struct coord: Codable {
    var lon : Double
    var lat: Double

}



struct main:Codable{
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
}

struct wind: Codable {
    var speed: Double
    var deg: Int
}

struct clouds:Codable{
    var all: Int
}




struct sys: Codable{
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset:Int
}


var celsius = false


func convertDegrees(degreese: Double, celsiusTouchInside: Bool ) -> Int {
    let celsius = (degreese) - 273.15
    let fahrenheit = (celsius * 1.8) + 32
    if celsiusTouchInside {
        return Int(celsius)
    } else {
        return Int(fahrenheit)
    }
    
}

func setTheBackground(accordingWith Apiresponse: apiResponseForHourForecastinAndDay, viewController: UIViewController ){
if didSunsetOccured(data: Apiresponse) {
    viewController.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundForNightTime.jpg")!)
}else {
    viewController.view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
}
}
 
 
                 
