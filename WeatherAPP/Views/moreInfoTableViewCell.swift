//
//  moreInfoTableViewCell.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/7/21.
//

import UIKit

class moreInfoTableViewCell: UITableViewCell {

    
    func update(hourly: Hourly?, daily: Daily? ){
        if let hourly = hourly {
            self.textLabel?.text = "Feels like"
            self.detailTextLabel?.text = "\(convertDegrees(degreese:  hourly.feels_like, celsiusTouchInside: celsius))"
            
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
