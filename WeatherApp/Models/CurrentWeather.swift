//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Ekaterina Kugeneva on 21.01.2022.
//

import Foundation

struct CurrentWeather  {
    let cityName : String
    let temperature : Double
    var temperatureString : String {
        return "\(temperature.rounded())"
    }
    
    let temperatureFeelsLike: Double
    var temperatureFeelsLikeString : String {
        return "\(temperatureFeelsLike.rounded())ºC"
    }
    let conditionCode : Int
    var systemIconNameString : String {
        switch conditionCode  {
        case 200 ... 232 : return "cloud.bolt.rain.fill"
        case 300 ... 321 : return "cloud.drizzle.fill"
        case 500 ... 531 : return "cloud.rain.fill"
        case 600 ... 622 : return "cloud.snow.fill"
        case 701 ... 781 : return "smoke.fill"
        case 800 : return "sun.min.fill"
        case 801 ... 804 : return "cloud.fill"
            
        default:
            return "nosign"
        }
    }
    
    init?(weatherData : WeatherData) {
        cityName = weatherData.name
        temperature = weatherData.main.temp
        temperatureFeelsLike = weatherData.main.feelsLike
        conditionCode = weatherData.weather.first!.id
    }
}
