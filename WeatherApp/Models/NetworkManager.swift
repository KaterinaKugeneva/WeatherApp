//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Ekaterina Kugeneva on 21.01.2022.
//

import Foundation
import UIKit

struct NetworkManager {
    
    var onCompletion : ((CurrentWeather) -> Void)?
    
    func fetchWeather (city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                //let dataString = String(data: data, encoding: .utf8)
                //print (dataString!)
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON (withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try  decoder.decode(WeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(weatherData: weatherData) else {return nil}
            return currentWeather
            //print(weatherData.main.temp)
        } catch let error as NSError {
            print (error.localizedDescription)
            return nil
            
        }
                
    }
}
