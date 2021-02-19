//
//  moreInfoForecastVC.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/7/21.
//

import UIKit

class moreInfoForecastVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    private(set) var additionalHourlyInfo = [Hourly?]()
    private(set) var ApiResponse:apiResponseForHourForecastinAndDay?
    private(set) var additionalWeekDayInfo = [Daily?]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func InitAdditionalHourlyInfo(with Apiresponse: Hourly){
        additionalHourlyInfo.append(Apiresponse)
    }
    
    func InitAdditionalWeelInfo(with ApiResponse: Daily){
        additionalWeekDayInfo.append(ApiResponse)
    }
    
    func InitNewValueAPiresponse(with Apiresponse: apiResponseForHourForecastinAndDay){
        ApiResponse = Apiresponse
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTheBackground(accordingWith: ApiResponse! , viewController: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    

 

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if additionalHourlyInfo.count > 0{
            return additionalHourlyInfo.count
        } else {
            return additionalWeekDayInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if additionalHourlyInfo.count > 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "forecast", for: indexPath) as? moreInfoTableViewCell {
                let hourly = ApiResponse?.hourly[indexPath.row]
                cell.update(hourly: hourly, daily: nil)
               return cell
            }
        }else {
            //daily set up
        }
        return moreInfoTableViewCell()
    }
    
}
