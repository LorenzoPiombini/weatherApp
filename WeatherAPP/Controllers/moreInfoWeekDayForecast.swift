//
//  moreInfoWeekDayForecast.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/6/21.
//

import UIKit

class moreInfoWeekDayForecast: UIViewController {
    
    @IBOutlet weak var imageForecast: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelsLikeDegreeLabel: UILabel!
    @IBOutlet weak var humidityPercentageLabel: UILabel!
    @IBOutlet weak var pressuereLabel: UILabel!
    @IBOutlet weak var uviLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var probailityOfPrecipitationLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
   
    private(set) var additionalWeekDayInfo:Daily?
    private(set) var ApiResponse:apiResponseForHourForecastinAndDay?
    
   
    
    func InitAdditionalWeelInfo(with ApiResponse: Daily){
        additionalWeekDayInfo = ApiResponse
    }
    
    func InitNewValueAPiresponse(with Apiresponse: apiResponseForHourForecastinAndDay){
        ApiResponse = Apiresponse
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setTheBackground(accordingWith: ApiResponse! , viewController: self)
//        updateView(with: nil, ApiResponseDaily: additionalWeekDayInfo, descriptionLbl: descriptionLabel, feelsLikeLbl: feelsLikeDegreeLabel, humidityLbl: humidityPercentageLabel, windSpeedLbl: windSpeedLabel, visibilityLbl: visibilityLabel, pressureLbl: pressuereLabel, probailityOfPrecipitationLbl: probailityOfPrecipitationLabel, uvilbl: uviLabel, maxTemp: maxTempLabel, minTemp: minTempLabel, sunriseLbl: sunriseLabel, Sunset: sunsetLabel, image: imageForecast)
//        
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
