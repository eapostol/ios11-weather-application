//
//  ForecastCell.swift
//  weather-application
//
//  Created by Edward Apostol on 2018-05-17.
//  Copyright © 2018 edward. All rights reserved.
//

import Foundation
import UIKit

class ForecastCell: UITableViewCell
{
    
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setForecast(forecast: ForecastObject)
    {
        self.dateLabel.text = forecast.dateString
        self.weatherLabel.text = forecast.dayTemp
        self.highLabel.text = forecast.highTemp
        self.lowLabel.text = forecast.lowTemp
    }
    
}
