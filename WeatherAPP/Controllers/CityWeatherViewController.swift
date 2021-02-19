//
//  CityWeatherViewController.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/18/21.
//

import UIKit


class CityWeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
 
    private(set) var city:String?
    private(set) var coord:coord?
    
    func initCityData(array:[Any]){
        city = "\(array[0])"
        coord = array[1] as? coord
    }
    
    // the following is the variable to store the data from the API
    var dailyAndHourlyWeather:apiResponseForHourForecastinAndDay?
   
    //all the outlet in the view
    
    @IBOutlet weak var locationLbl:UILabel!
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var weatherConditionlbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var degreesLbl: UILabel!
    @IBOutlet weak var todayBtn: UIButton!
    @IBOutlet weak var weekBtn: UIButton!
    @IBOutlet weak var collectionViewForecast: UICollectionView!
    @IBOutlet weak var lowerTemperature: UILabel!
    @IBOutlet weak var highestTemerature: UILabel!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionViewForecast.delegate = self
        collectionViewForecast.dataSource = self
      
        todayLbl.text = dateFormat() // using the dateFormat() function to display the date as of today
        
        
        fecthingAPIweatherForcastingData()
    }
    
    
    @IBAction func getFiveDays(_ sender: Any ){
        todayBtn.alpha = 1
        weekBtn.alpha = 0.5
        collectionViewForecast.reloadData()
   
        
    }
    
    @IBAction func getTodayweather(_ sender: Any){
        weekBtn.alpha = 1
        todayBtn.alpha = 0.5
        collectionViewForecast.reloadData()
       
    }
    
    @IBAction func changeDeegreeUnit(_ sender: Any){
        if celsius {
        celsius = false
        }else {
            celsius = true
        }
        collectionViewForecast.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dailyAndHourlyWeather?.hourly == nil {
            return 0
        }else if weekBtn.alpha == 1.0 {
            
            return dailyAndHourlyWeather!.hourly.count
        }else {
            
            return dailyAndHourlyWeather!.daily.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if weekBtn.alpha == 1.0 {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecast", for: indexPath) as? forecastingCollectioViewCell {
            
            if let hourly = dailyAndHourlyWeather?.hourly[indexPath.row] {
                
            cell.updateForcastingCollectioViewCell(data: hourly)
                
            return cell
            } else {
                return forecastingCollectioViewCell()
            }
            
        }} else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecast", for: indexPath) as? forecastingCollectioViewCell{
            
            if  let daily = dailyAndHourlyWeather?.daily[indexPath.row] {
                 
                    cell.updateForecastingCollectionViewCellWithTheWeek(data: daily)
                    return cell
        }
        }
        return forecastingCollectioViewCell()
            
    
    }
    
    func fecthingAPIweatherForcastingData(){
        Network.shared.lon = coord!.lon
        Network.shared.lat = coord!.lat
        
        Network.shared.getTheHourlyAndDailyWeather { [self] (apiResponseForHourForecastinAndDay) in
            self.dailyAndHourlyWeather = apiResponseForHourForecastinAndDay
            self.collectionViewForecast.reloadData()
            
            locationLbl.text = city
            weatherConditionlbl.text = "Currently \(dailyAndHourlyWeather!.current.weather[0].description)"
            weatherImage.loadFrom(url: URL(string: "http://openweathermap.org/img/wn/\(dailyAndHourlyWeather?.current.weather[0].icon ?? "nothing").png")!)
            degreesLbl.text = "\(convertDegrees(degreese: (dailyAndHourlyWeather?.current.temp)!, celsiusTouchInside: celsius ))°"
            degreesLbl.text = "\(convertDegrees(degreese: (dailyAndHourlyWeather?.current.temp)!, celsiusTouchInside: celsius ))°"
            lowerTemperature.text = "Lowest: \(convertDegrees(degreese: dailyAndHourlyWeather!.daily[0].temp.min, celsiusTouchInside: celsius))°"
            highestTemerature.text = "Highest: \(convertDegrees(degreese: dailyAndHourlyWeather!.daily[0].temp.max, celsiusTouchInside: celsius))°"
        
        setTheBackground(accordingWith: dailyAndHourlyWeather!, viewController: self)
        } onError: { (error) in
            print(error)
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
