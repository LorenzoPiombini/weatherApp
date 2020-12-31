//
//  weather.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 12/27/20.
//

import Foundation


struct apiResponses: Codable{
    let items: Array<apiResponse>
}

struct apiResponse:Codable {
    var coord:coord
    var weather:[weather]
    var base: String
    var main:main
    var visibility: Int
    var wind: wind
    var clouds: clouds
//    var rain: Array<rain?>
//    var snow: Array<snow?>
    var dt : Int
    var sys: sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
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

struct rain:Codable{
    var h1 = 0.0
    var h3 = 0.0
}

struct snow: Codable{
    var h1: Double
    var h3: Double
    
}

struct sys: Codable{
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset:Int
}



  
    
 

                 
