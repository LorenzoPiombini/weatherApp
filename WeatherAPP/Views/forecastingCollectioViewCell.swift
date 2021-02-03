//
//  forecastingCollectioViewCell.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/2/21.
//

import UIKit

class forecastingCollectioViewCell: UICollectionViewCell {
    @IBOutlet weak var weatherImageCVC: UIImageView!
    @IBOutlet weak var dayOrHourLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    
    
    func updateForecastingCollectionViewCellWithTheWeek(data: Daily){
        weatherImageCVC.loadFrom(url: createImageURLtoCacheImageWeek(imageIconStoreIn: data))
        dayOrHourLabel.text = "\(dayFormatter(fromDayTime: data))"
        degreeLabel.text = "\(convertDegrees(degreese: data.temp.day, celsiusTouchInside: celsius))°"
    }
    
    func updateForcastingCollectioViewCell(data: Hourly){
        weatherImageCVC.loadFrom(url: createImageURLtoCacheImage(imageIconStoreIn: data))
        dayOrHourLabel.text = "\(hourFormatter(fromData: data))"
        degreeLabel.text = "\(convertDegrees(degreese: data.temp, celsiusTouchInside: celsius ))°"
    }
    
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

    func dayFormatter(fromDayTime: Daily)-> String{
        let interval = (fromDayTime.dt)
        let now = Date(timeIntervalSince1970: TimeInterval(interval))
        let dateFormatter = DateFormatter()
        let  now2 = dateFormatter.calendar.component(.weekday, from: now)
        return "\(weekDays[now2]!)"
    }
    
    
    
    func hourFormatter(fromData: Hourly)-> String{
        let interval = (fromData.dt)
        let now = Date(timeIntervalSince1970: TimeInterval(interval))
        let dateFormatter = DateFormatter()
        let  now2 = dateFormatter.calendar.component(.hour, from: now)
               
                if now2 - 12 < 0 && now2 - 12 > -12 {
                    return "\(now2) am "
                } else if now2 - 12 == 0 {
                    return "\(now2) pm"
                } else if  now2 - 12 == -12 {
                    return "\(now2 + 12) am"
                }else {
                    return "\(now2 - 12 ) pm"
                }
    }
}
