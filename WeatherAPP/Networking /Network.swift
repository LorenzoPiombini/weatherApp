//
//  Network.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 12/23/20.
//

import Foundation

class Network {
 static let shared = Network()
      var location: String = ""
    
    let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?q="
    let apiKey = "&appid=cbd0e879af413ccd5c5090cf8187f5c1"
    
    let session = URLSession(configuration: .default)
    
    
    func getTheWeather(onSuccess: @escaping (apiResponses)-> Void, onError: @escaping (String)->Void ){
        let locationURL = "\(location)"
        let url = URL(string: "\(BASE_URL)\(locationURL)\(apiKey)")!
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
                        let items = try JSONDecoder().decode(apiResponses.self, from:data)
                        onSuccess(items)
                    }else{
                        let error = try JSONDecoder().decode(APIError.self, from: data)
                        onError(error.message)
                    }
                }
                catch{
                    onError(error.localizedDescription)
                }
                
        }
            
            
        }
        task.resume()
        
        
        
        
        
    }

}
