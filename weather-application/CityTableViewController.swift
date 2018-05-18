//
//  CityTableViewController.swift
//  weather-application
//
//  Created by Edward Apostol on 2018-05-17.
//  Copyright © 2018 edward. All rights reserved.
//

import Foundation
import UIKit

class CityTableViewController: UITableViewController
{
    var cities: Array<String>!
    
    override func viewDidLoad() {
        cities = Array<String>()
        cities.append("Toronto")
        cities.append("Honolulu")
        cities.append("Los Angeles")
        cities.append("Pittsburgh")
        cities.append("Cleveland")
        cities.append("Paris")
        
        let nib = UINib(nibName: "CityCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CityCellID")
        
        self.title = "Cities"
        self.tableView.reloadData()
    }
    
    // implement override func tableView - numberOfRowsInSection
    // return cities.count
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    // implement override func tableView - cellForRowAt
    // return UITableViewCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCellID") as! CityCell
        cell.setCity(city: cities[indexPath.row])
        return cell
    }
    
    // implement override func tableView - didSelectRowAt
    // get the forecastTableView. then push it to the top of stack
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(cities[indexPath.row])
        let forecastTable = ForecastTableView(city: cities[indexPath.row])
        self.navigationController?.pushViewController(forecastTable, animated: true)
    }
    
    
}
