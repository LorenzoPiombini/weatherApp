//
//  Network.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 12/23/20.
//

import Foundation
import CoreLocation
import UIKit

class Network {
 static let shared = Network()
    var location: String = ""
    var lon: Double = 0.0
    var lat: Double = 0.0
    let BASE_URL = "https://api.openweathermap.org/data/2.5/"
    let apiKey = "&appid=cbd0e879af413ccd5c5090cf8187f5c1"
    let session = URLSession(configuration: .default)
    
    
    func getTheWeather(onSuccess: @escaping (apiResponse)-> Void, onError: @escaping (String)->Void ){
       
        let weatherParam = "weather?q=\(location)"
        let url = URL(string: "\(BASE_URL)\(weatherParam)\(apiKey)")!

        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
            }
                
                guard let data = data, let response = response as? HTTPURLResponse   else {
                    debugPrint("invalid data or Response")
                    return}
                
                do{
                    if response.statusCode == 200 {
                        let item = try JSONDecoder().decode(apiResponse.self, from:data)
                        onSuccess(item)
                    }else{
                        let error = try JSONDecoder().decode(APIError.self, from: data)
                        onError(error.message)
                    }
                }
                catch{
                    onError("\(error)")
                }
                
        }
            
            
        }
        task.resume()
        
        
        
        
        
    }
    
    func getTheHourlyAndDailyWeather(onSucces: @escaping (apiResponseForHourForecastinAndDay)->Void, onError: @escaping (String)-> Void){
        let coordinateUrl = "lat=\(lat)&lon=\(lon)"
        let excludeItemFromTheApiResponse = "&exclude=alerts,minutely"
        let url = URL(string: "\(BASE_URL)onecall?\(coordinateUrl)\(excludeItemFromTheApiResponse)\(apiKey)")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    debugPrint("invalid data or Response ")
                    return}
                do{
                    if response.statusCode == 200 {
                        let item = try JSONDecoder().decode(apiResponseForHourForecastinAndDay.self, from: data)
                        onSucces(item)
                    }else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                    
                    
                }
                catch{
                    onError("\(error)")
                }
            }
        }
        task.resume()
    }

    


}
