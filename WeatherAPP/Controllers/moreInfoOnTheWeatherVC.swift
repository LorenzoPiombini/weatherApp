//
//  moreInfoOnTheWeatherVC.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/6/21.
//

import UIKit

class moreInfoOnTheWeatherVC: UIViewController {

    @IBOutlet weak var imageForecast: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelsLikeDegreeLabel: UILabel!
    @IBOutlet weak var humidityPercentageLabel: UILabel!
    @IBOutlet weak var pressuereLabel: UILabel!
    @IBOutlet weak var uviLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var probailityOfPrecipitationLabel: UILabel!
    
    
    private(set) var additionalHourlyInfo:Hourly?
    private(set) var ApiResponse:apiResponseForHourForecastinAndDay?
    
    func InitAdditionalHourlyInfo(with Apiresponse: Hourly){
        additionalHourlyInfo = Apiresponse
    }
    
  
    
    func InitNewValueAPiresponse(with Apiresponse: apiResponseForHourForecastinAndDay){
        ApiResponse = Apiresponse
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        updateView(with: additionalHourlyInfo, ApiResponseDaily: nil, descriptionLbl: descriptionLabel, feelsLikeLbl: feelsLikeDegreeLabel, humidityLbl: humidityPercentageLabel, windSpeedLbl: windSpeedLabel, visibilityLbl: visibilityLabel, pressureLbl: pressuereLabel, probailityOfPrecipitationLbl: probailityOfPrecipitationLabel, uvilbl: uviLabel, maxTemp: nil, minTemp: nil, sunriseLbl: nil, Sunset: nil, image: imageForecast)
     
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
