//
//  ImageFetchingHelper.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 1/31/21.
//

import Foundation
import UIKit


func createImageURLtoCacheImage(imageIconStoreIn:Hourly)-> URL {
    let imageBaseurl = "http://openweathermap.org/img/wn/"
    let imageName = "\(imageIconStoreIn.weather[0].icon).png"
    let url = URL(string: "\(imageBaseurl)\(imageName)")!
    return url
}

func createImageURLtoCacheImageWeek(imageIconStoreIn:Daily)-> URL {
    let imageBaseurl = "http://openweathermap.org/img/wn/"
    let imageName = "\(imageIconStoreIn.weather[0].icon).png"
    let url = URL(string: "\(imageBaseurl)\(imageName)")!
    return url
}

extension UIImageView{
    func loadFrom(url: URL){
         DispatchQueue.global().async {
             [weak self] in
             if let data = try? Data(contentsOf: url) {
                 if let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                         self?.image = image
                         }
                 }
                 
             }
         }
     }
}
