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
    
    
    func updateForecastingCollectionViewCellWithTheWeek(data: Daily, timeOffSet: Int){
        weatherImageCVC.loadFrom(url: createImageURLtoCacheImageWeek(imageIconStoreIn: data))
        dayOrHourLabel.text = "\(dayFormatter(fromDayTime: data, timeOffSet: timeOffSet))"
        degreeLabel.text = "\(convertDegrees(degreese: data.temp.day, celsiusTouchInside: celsius))°"
    }
    
    func updateForcastingCollectioViewCell(data: Hourly, timeOffSet: Int){
        weatherImageCVC.loadFrom(url: createImageURLtoCacheImage(imageIconStoreIn: data))
        dayOrHourLabel.text = "\(hourFormatter(fromData: data.dt, timeOffSet: timeOffSet, callingFromCityWeatherController: false))"
        degreeLabel.text = "\(convertDegrees(degreese: data.temp, celsiusTouchInside: celsius ))°"
    }
    


    func dayFormatter(fromDayTime: Daily, timeOffSet: Int)-> String{
        let interval = (fromDayTime.dt)
        let now = Date(timeIntervalSince1970: TimeInterval(interval))
        let dateFormatter = DateFormatter()
        let  now2 = dateFormatter.calendar.component(.weekday, from: now)
        return "\(weekDays[now2]!)"
    }
    
    
    
//    func hourFormatter(fromData: Int, timeOffSet: Int)-> String{
//        let fiveHoursInSeconds = 3600 * 5
//        let hoursDescrepancyBetweenHereandTimeIffSet = ((timeOffSet)/60)/60 + ((fiveHoursInSeconds / 60)) / 60
//        let interval = fromData
//        let now = Date(timeIntervalSince1970: TimeInterval(interval))
//        let dateFormatter = DateFormatter()
//
//        var  now2 = dateFormatter.calendar.component(.hour, from: now)
//         now2 = now2 + hoursDescrepancyBetweenHereandTimeIffSet
//                if now2 - 12 < 0 && now2 - 12 > -12 {
//                    return "\(now2) am "
//                } else if now2 - 12 == 0 {
//                    return "\(now2) pm"
//                } else if  now2 - 12 == -12 {
//                    return "\(now2 + 12) am"
//                }else {
//                    return "\(now2 - 12 ) pm"
//                }
//    }
}
