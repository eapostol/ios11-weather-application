//
//  CityCell.swift
//  weather-application
//
//  Created by Edward Apostol on 2018-05-17.
//  Copyright © 2018 edward. All rights reserved.
//

import Foundation
import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    // func setCity
    func setCity(city: String){
        // assign the city value to the text property of this cell
        self.cityLabel?.text = city
        // call the getWeatherData method, passing city
        self.getWeatherData(city: city)
    }
    
    
    // func getWeatherData
    func getWeatherData(city: String){
        // let weatherApiURL = "http://api.openweathermap.org/data/2.5/weather?"
        let weatherApiURL = "http://api.openweathermap.org/data/2.5/weather"
        // let q = "\(weatherApiURL)q=\(city)"
        let apiKey = "31e85525b688a591b79d57a6548f24b7"
        let params = "&units=metric&appid=\(apiKey)"
        
        // let urlString = "\(q)\(params)"
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        dataTask?.cancel()
        var urlComponents = URLComponents(string: weatherApiURL)
        urlComponents?.query = "q=\(city)\(params)"
        
        guard let url = urlComponents?.url else { return }
        
        print(url)
        
        dataTask = defaultSession.dataTask(with: url)
        {
            data, response, error in
            NSLog("We've processed the request")
            do
            {
                if let weatherData = data{
                    let response = response as? HTTPURLResponse
                    if response?.statusCode == 200
                    {
                        if let dictionary = try JSONSerialization.jsonObject(with: weatherData, options: []) as? NSDictionary
                        {
                            self.setWeatherData(weatherDict: dictionary)
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
    
    func setWeatherIcon(iconString: String){
        // http://openweathermap.org/img/w/02d.png
        let weatherApiURL = "http://openweathermap.org/img/w/\(iconString).png"
        let urlComponents = URLComponents(string: weatherApiURL)
        guard let url = urlComponents?.url else { return }
        print(url)
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url)
        {
            (data, response, error) -> Void in
                if let imageData = data{
                    let response = response as? HTTPURLResponse
                    if response?.statusCode == 200 {
                        DispatchQueue.main.async {
                            self.weatherImageView.image = UIImage(data: imageData)
                        }
                    }
                }
        }
        dataTask?.resume()
        
    }

    func setWeatherData(weatherDict: NSDictionary){
        print("Setting the temperature label...")
        // Load Temperature
        let mainDict = weatherDict["main"] as! NSDictionary
        let weatherArray = weatherDict["weather"] as! Array<NSDictionary>
        
        let firstWeatherDict = weatherArray[0]
        let iconString = firstWeatherDict["icon"] as! String
        self.setWeatherIcon(iconString: iconString)
        
        let temp = (mainDict["temp"] as! NSNumber)
        // Update UI
        DispatchQueue.main.async(){
            self.tempLabel.text = "\(temp) C"
        }
    }
    
}
