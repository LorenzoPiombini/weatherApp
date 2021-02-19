//
//  ErrorHandling.swift
//  WeatherAPP
//
//  Created by Lorenzo piombini on 1/31/21.
//

import Foundation
import UIKit
struct ErrorHandling {
    func errorMessageLocation(Controller: UIViewController){
        let alertMessage = UIAlertController.init(title: "We have trouble find your location", message: "we have trouble finding your location. Check your settings and/or your connection", preferredStyle: .alert)
        let alertActionOk = UIAlertAction.init(title: "Ok", style: .default)
        let alertActionCancel = UIAlertAction.init(title: "Cancel", style: .cancel)
        let alertActionGoToSetting = UIAlertAction.init(title: "Go to Settings", style: .default) { (alertMessage) in
            let url = URL(string: "\(UIApplication.openSettingsURLString)")!
            UIApplication.shared.open(url)
        }
        alertMessage.addAction(alertActionOk)
        alertMessage.addAction(alertActionCancel)
        alertMessage.addAction(alertActionGoToSetting)
       Controller.present(alertMessage, animated: true, completion: nil)
    }
    
}
