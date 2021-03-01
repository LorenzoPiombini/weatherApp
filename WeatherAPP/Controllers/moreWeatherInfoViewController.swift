//
//  moreWeatherInfoViewController.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/21/21.
//

import UIKit

class moreWeatherInfoViewController: UIViewController {

    var hourlyWeatherInfo:Hourly?
    var dailyWaetherInfo:Daily?
    var allTheDataFromTheAPI:apiResponseForHourForecastinAndDay?
    
    func initDailyInfo(with Daily: Daily){
        dailyWaetherInfo = Daily
    }
    
    func initHorlyInfo(with Hourly: Hourly){
        hourlyWeatherInfo = Hourly
    }
    
    func initApiResponse(with ApiResponse: apiResponseForHourForecastinAndDay){
        allTheDataFromTheAPI = ApiResponse
    }
    
    //------ Stack view declaration to graphic pourpose
    @IBOutlet weak var minStackView: UIStackView!
    @IBOutlet weak var maxStackView: UIStackView!
    @IBOutlet weak var sunriseStackView: UIStackView!
    @IBOutlet weak var sunsetStackView: UIStackView!
    @IBOutlet weak var pressureStackView: UIStackView!
    @IBOutlet weak var visibilityStackView: UIStackView!
    @IBOutlet weak var windSpeedStackView: UIStackView!
    @IBOutlet weak var uvIndexStackView: UIStackView!
    @IBOutlet weak var chanceOfStackViewL: UIStackView!
    @IBOutlet weak var humidityStackView: UIStackView!
    //------ Label declaration
    @IBOutlet weak var feelsLikeDegreeLbl : UILabel!
    @IBOutlet weak var minDegreeLbl: UILabel!
    @IBOutlet weak var maxDegreeLbl: UILabel!
    @IBOutlet weak var sunsriseTimeLbl: UILabel!
    @IBOutlet weak var sunsetTimeLbl: UILabel!
    @IBOutlet weak var pressureValueLbl: UILabel!
    @IBOutlet weak var visibilityValueLbl: UILabel!
    @IBOutlet weak var windSpeedValueLbl: UILabel!
    @IBOutlet weak var uvIndexValueLbl: UILabel!
    @IBOutlet weak var chanceOfPercentage: UILabel!
    @IBOutlet weak var humidityValueLbl: UILabel!
    @IBOutlet weak var chanceOf: UILabel!
    //----- image
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheBackground(accordingWith: allTheDataFromTheAPI!, viewController: self)
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    
    func updateUI(){
        if let hourly = hourlyWeatherInfo{
            image.loadFrom(url:  createImageURLtoCacheImage(imageIconStoreIn: hourly))
            feelsLikeDegreeLbl.text = "\(convertDegrees(degreese: hourly.feels_like, celsiusTouchInside: celsius))°"
            let pressure = Double(hourly.pressure) * 0.02953
            print(pressure)
            pressureValueLbl.text = String(format: "%.2f", pressure)
            minDegreeLbl.text = "-"
            maxDegreeLbl.text = "-"
            sunsetTimeLbl.text = "-"
            sunsriseTimeLbl.text = "-"
            if let visibility = hourly.visibility {
                visibilityValueLbl.text = String(format: "%.2f", Double(visibility) * 0.000621371)
            } else {
                visibilityValueLbl.text = "-"
            }
            windSpeedValueLbl.text = String(format: "%.2f", hourly.wind_speed * 0.6214 )
            uvIndexValueLbl.text = "\(hourly.uvi)"
            if hourly.weather[0].description.contains("rain") ||
                hourly.weather[0].description.contains("Rain") {
                
                chanceOf.text = "Chance of Rain"
                
            }else if hourly.weather[0].description.contains("Snow" ) ||
                    hourly.weather[0].description.contains("snow"){
                chanceOf.text = "chance of Rain"
                
            }else {
                chanceOf.text = chanceOf.text! + " precipitation"
            }
            chanceOfPercentage.text = "\(Int(hourly.pop * 100))%"
            humidityValueLbl.text = "\(hourly.humidity)%"
            
        } else if let daily = dailyWaetherInfo{
            image.loadFrom(url: createImageURLtoCacheImageWeek(imageIconStoreIn: daily))
            feelsLikeDegreeLbl.text = "\(convertDegrees(degreese: daily.feels_like.day, celsiusTouchInside: celsius))°"
            minDegreeLbl.text = "\(convertDegrees(degreese: daily.temp.min, celsiusTouchInside: celsius))°"
            maxDegreeLbl.text = "\(convertDegrees(degreese: daily.temp.max, celsiusTouchInside: celsius))°"
            sunsetTimeLbl.text = "\(hourFormatter(fromData: daily.sunset, timeOffSet: allTheDataFromTheAPI!.timezone_offset, callingFromCityWeatherController: true))"
            sunsriseTimeLbl.text = "\( hourFormatter(fromData: daily.sunrise, timeOffSet: allTheDataFromTheAPI!.timezone_offset, callingFromCityWeatherController: true))"
            pressureValueLbl.text = String(format: "%.2f", Double(daily.pressure) *  0.02953)
            if let visibility = daily.visibility{
            visibilityValueLbl.text = String(format: "%.2f", Double(visibility) * 0.000621371)
            }else {
                visibilityValueLbl.text = "-"
            }
                
            windSpeedValueLbl.text = String(format: "%.2f", daily.wind_speed * 0.6214) // understand the converstion
            uvIndexValueLbl.text = "\(daily.uvi)"
            if daily.weather[0].description.contains("rain") ||
                daily.weather[0].description.contains("Rain") {
                
                chanceOf.text = "Chance of Rain"
                
            }else if daily.weather[0].description.contains("Snow" ) ||
                    daily.weather[0].description.contains("snow"){
                chanceOf.text = "chance of Rain"
                
            }else {
                chanceOf.text = chanceOf.text! + " precipitation"
            }
            chanceOfPercentage.text = "\(Int(daily.pop * 100))%"
            humidityValueLbl.text = "\(daily.humidity)%"
            
            
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
