//
//  cityTableViewCell.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 2/18/21.
//

import UIKit

class cityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func updateUI(with city: String){
       
        self.textLabel?.text = city
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
