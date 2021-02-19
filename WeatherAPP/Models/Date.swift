//
//  Date.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 1/3/21.
//

import Foundation

var month:[Int:String] = [1:"January", 2:"February", 3:"March", 4:"April", 5:"May", 6:"June", 7:"July", 8:"August", 9:"September", 10:"October", 11:"November", 12:"December"]


var weekDays:[Int:String] = [1:"Sunday", 2:"Monday", 3:"Tuesday", 4:"Wednesday", 5:"Thursday", 6:"Friday", 7:"Saturday"]


func dateFormat()-> String{
    // this function to displaying the date on the app screen
    // since the calendar compnent throws a number as a month and day identifier i thought it was easy
    // made use of dictionary as per line 10 and line 13 
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "mm-GG"
    let today = Date()
   let day =  dateFormatter.calendar.component(.day, from: today)
    let monthIdentifier = dateFormatter.calendar.component(.month, from: today)
    let daynameIdentifier = dateFormatter.calendar.component(.weekday, from: today)
    var dayOutput = ""
    dayOutput = "\(weekDays[daynameIdentifier]!), \(month[monthIdentifier]!) \(day)"
    return dayOutput
    }

func didSunsetOccured(data: apiResponseForHourForecastinAndDay) -> Bool {
    //this function is for setting the view`s  background based on the time(day/night)
    let now = Date()
    let dateFormatter = DateFormatter()
    let hour = dateFormatter.calendar.component(.hour, from: now)
    let sunset = data.current.sunset
    let realSunset = Date(timeIntervalSince1970: TimeInterval(sunset))
    let sunsetHour = dateFormatter.calendar.component(.hour, from: realSunset)
    let sunrise = data.current.sunrise
    let realSunrise = Date(timeIntervalSince1970: TimeInterval(sunrise))
    let sunRiseHour = dateFormatter.calendar.component(.hour, from: realSunrise)
    if (  sunsetHour - hour) < 0 {
        return true
    }else if (hour - sunRiseHour) < 0 {
        return true
    }else {
        return false
    }
    
}

func dayFormatter(fromDayTime: Daily)-> String{
    let interval = (fromDayTime.dt)
    let now = Date(timeIntervalSince1970: TimeInterval(interval))
    let dateFormatter = DateFormatter()
    let  now2 = dateFormatter.calendar.component(.weekday, from: now)
    return "\(weekDays[now2]!)"
}


   
    
    
    
   

