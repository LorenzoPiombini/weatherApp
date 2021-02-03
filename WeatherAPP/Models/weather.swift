//
//  weather.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 12/27/20.
//

import Foundation




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
  var weather: [weather]
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
  var weather: [weather]
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
    var weather: [weather]
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



struct weather: Codable {
    var  id: Int
    var  main: String
    var description: String
    var icon: String
}


struct coord: Codable{
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
    
 

                 
