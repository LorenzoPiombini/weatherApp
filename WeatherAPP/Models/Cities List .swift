//
//  Cities List .swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/14/21.
//

import Foundation
import FirebaseDatabase



struct City: Codable {
    var coord: coord
    var country: String
    var id: Int
    var name: String
    var state: String?
    
    

    
   
    
    
   
}

struct Cities: Codable {
    var cities:City
}


func fetchingCityList(onSuccess: @escaping ([City])->Void, onError: @escaping (String)->Void) {
  let url = "https://science-weather-up-default-rtdb.firebaseio.com/.json"
  
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                onError("\(error.localizedDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                onError("invalid data or request")
            return
            }
            
            do{
                if response.statusCode == 200 {
                    let cities = try JSONDecoder().decode([City].self, from: data)
                    onSuccess(cities)
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


