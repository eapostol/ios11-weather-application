//
//  ForecastObject.swift
//  weather-application
//
//  Created by Edward Apostol on 2018-05-17.
//  Copyright © 2018 edward. All rights reserved.
//

import Foundation

class ForecastObject{
    var dateString: String
    var cityName: String
    
    var dayTemp: String
    var highTemp: String
    var lowTemp: String
    
    init(city: String, dict: NSDictionary)
    {
        self.cityName = city
        // Temperature
        let tempDict = dict["main"] as! NSDictionary
        // let day = tempDict["day"] as! NSNumber
        let day = tempDict["temp"] as! NSNumber

        self.dayTemp = "\(day) deg"
        // as above, do the same to set highTemp and lowTemp props.
        let highTemp = tempDict["temp_max"] as! NSNumber
        let lowTemp = tempDict["temp_min"] as! NSNumber
        
        self.highTemp = "\(highTemp) deg"
        self.lowTemp = "\(lowTemp) deg"
        
        self.dateString = ""
        
    }
    
}
