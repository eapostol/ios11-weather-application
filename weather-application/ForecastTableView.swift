//
//  ForecastTableView.swift
//  weather-application
//
//  Created by Edward Apostol on 2018-05-17.
//  Copyright © 2018 edward. All rights reserved.
//

import Foundation
import UIKit

class ForecastTableView: UITableViewController
{
    var city: String!
    var forecasts: Array<ForecastObject>!
    
    
    init(city:String)
    {
        // print(city) printing here proved city was ok (not optional)
        self.city = city
        // print(self.city) printing here proved self.city was ok
        super.init(style: UITableViewStyle.plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "ForecastCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ForecastCellID")
        // print(self.city) self.city was a string here as well
        self.title = "\(self.city!) Forecast"
        // forced unwrap self.city to fix title.
        self.getForecasts()
    }
    
    func getForecasts()
    {
        // discovered that openweathermap no longer supports 7 day (16 day) for free
        // let weatherApiURL = "http://api.openweathermap.org/data/2.5/forecast/daily"
        
        let weatherApiURL = "http://api.openweathermap.org/data/2.5/forecast/"

        let apiKey = "31e85525b688a591b79d57a6548f24b7"
        let params = "&mode=json&cnt=7&units=metric&APPID=\(apiKey)"
        var urlComponents = URLComponents(string: weatherApiURL)
        let theCity = self.city!
        // print(theCity) making theCity be an unwrapped version of theCity returned
        // a string
        
        urlComponents?.query = "q=" + theCity + "\(params)"
        
        guard let url = urlComponents?.url else { return }
        print(url)
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url)
        {
            data, response, error in
            NSLog("We've processed the FORECAST request")
            do
            {

                if let forecastData = data
                {
                    let response = response as? HTTPURLResponse
                    print("**** The forecast response is below ****")
                    print(response!)
                    print("**** end of forecast response ****")
                    if response?.statusCode == 200
                    {
                        print("We have data...")
                        if let dictionary = try JSONSerialization.jsonObject(with: forecastData, options: []) as? NSDictionary
                        {
                            print("setting up the forecast to be displayed")
                            self.setForecasts(forecastDict: dictionary)
                        }
                    }
                }
            }
            catch
            {
                print(error)
            }
        }
        dataTask?.resume()
    }
    
    func setForecasts(forecastDict:NSDictionary)
    {
        let forecastList = forecastDict["list"] as! Array<NSDictionary>
        DispatchQueue.main.async(){
            self.forecasts = Array<ForecastObject>()
            for dict in forecastList
            {
                self.forecasts.append(ForecastObject(city: self.city, dict: dict))
            }
        }
        // self.tableView.reloadData();
        // It is suggested only to reload data / update UI on main thread
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.forecasts == nil ) ? 0 : self.forecasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCellID") as! ForecastCell
        cell.setForecast(forecast: self.forecasts[indexPath.row])
        return cell
    }
}
