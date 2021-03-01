//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 12/23/20.
//


import UIKit
import CoreLocation


class weatherDisplay: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    
    var city:City?
    var locationManager = LocationManager()
    let errorHandling = ErrorHandling()
    
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
      

        collectionViewForecast.dataSource = self
        collectionViewForecast.delegate = self
        
        locationManager.locationConfing(delegate: self)
        locationManager.startFindingLocation()
        
        todayLbl.text = dateFormat() // using the dateFormat() function to display the date as of today
        
        
        
        
    
    
    
    
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
        degreesLbl.text = "\(convertDegrees(degreese: (dailyAndHourlyWeather?.current.temp)!, celsiusTouchInside: celsius ))°"
        lowerTemperature.text = "Lowest: \(convertDegrees(degreese: dailyAndHourlyWeather!.daily[0].temp.min, celsiusTouchInside: celsius))°"
        highestTemerature.text = "Highest: \(convertDegrees(degreese: dailyAndHourlyWeather!.daily[0].temp.max, celsiusTouchInside: celsius))°"
        collectionViewForecast.reloadData()
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.locationStatus()
    }
    
    // I used this method to generate the API call since the location was crucial for the API call.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        
        let translatorUserFriendly = CLGeocoder()
        //using lat and lon from locations[0], those params will be useful to do the Api call for the apiResponseForHourForecastinAndDay?
        Network.shared.lon = locations[0].coordinate.longitude
        Network.shared.lat = locations[0].coordinate.latitude
       
        // here i try to geocode the Location see the closure below
       translatorUserFriendly.reverseGeocodeLocation(locations[0]) { [self] (placemark: [CLPlacemark]?, error: Error?)->Void in
        // since the placemark could be missing i used a if let statment avoiding crashes
        if let placemark = placemark{
             
                locationLbl.text = "\(placemark[0].locality!)"
           
            
            
            Network.shared.getTheHourlyAndDailyWeather { (apiResponseForHourForecastinAndDay) in
                self.dailyAndHourlyWeather = apiResponseForHourForecastinAndDay
                self.collectionViewForecast.reloadData()
                // this is the same func that the Today`s btn will call when touchUp inside.
                //i put the func here cause you will see the data fotr the five hours worth weather
                // when the app is loaded.
                
                weatherConditionlbl.text = "Currently: \(dailyAndHourlyWeather!.current.weather[0].description)"
                weatherImage.loadFrom(url: URL(string: "http://openweathermap.org/img/wn/\(dailyAndHourlyWeather?.current.weather[0].icon ?? "nothing").png")!)
            
                    degreesLbl.text = "\(convertDegrees(degreese: (dailyAndHourlyWeather?.current.temp)!, celsiusTouchInside: celsius ))°"
                
                degreesLbl.text = "\(convertDegrees(degreese: (dailyAndHourlyWeather?.current.temp)!, celsiusTouchInside: celsius ))°"
                lowerTemperature.text = "Lowest: \(convertDegrees(degreese: dailyAndHourlyWeather!.daily[0].temp.min, celsiusTouchInside: celsius))°"
                highestTemerature.text = "Highest: \(convertDegrees(degreese: dailyAndHourlyWeather!.daily[0].temp.max, celsiusTouchInside: celsius))°"
                
                setTheBackground(accordingWith: dailyAndHourlyWeather!, viewController: self)
                
            } onError: { (Error) in
                print(Error)
            }
                
                } else {
                    errorHandling.errorMessageLocation(Controller: self)
                
                   print(error!)
                }
       }
        
       
        
        
        // called here to call this CLLocationManager delegate just once, to recall it again press update btn on the right hand side of the Screen
        
        
        locationManager.stopFindngLocation()

    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("What is going on ?")
        errorHandling.errorMessageLocation(Controller: self)
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
                
                cell.updateForcastingCollectioViewCell(data: hourly, timeOffSet: dailyAndHourlyWeather!.timezone_offset)
                
            return cell
            } else {
                return forecastingCollectioViewCell()
            }
            
        }} else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecast", for: indexPath) as? forecastingCollectioViewCell{
            
            if  let daily = dailyAndHourlyWeather?.daily[indexPath.row] {
                 
                cell.updateForecastingCollectionViewCellWithTheWeek(data: daily, timeOffSet: dailyAndHourlyWeather!.timezone_offset)
                    return cell
        }
        }
        return forecastingCollectioViewCell()
            }
    
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if weekBtn.alpha == 1.0 {
        let hourly = dailyAndHourlyWeather?.hourly[indexPath.row]
         performSegue(withIdentifier: "detailsForecast", sender: hourly)
        } else {
            let daily = dailyAndHourlyWeather?.daily[indexPath.row]
            performSegue(withIdentifier: "detailsForecast", sender: daily)
        }
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let moreWeatherInfo = segue.destination as? moreWeatherInfoViewController{
            if weekBtn.alpha == 1.0 {
                moreWeatherInfo.initHorlyInfo(with: sender as! Hourly)
           
            
            }else{
                moreWeatherInfo.initDailyInfo(with: sender as! Daily)
            }
            moreWeatherInfo.allTheDataFromTheAPI = dailyAndHourlyWeather
        }
    }
   
}



