//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ekaterina Kugeneva on 09.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkManager = NetworkManager()
    
    @IBAction func searchPressed(_ sender: Any) {
        self.showSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert){ [ unowned self ] city in self.networkManager.fetchWeather(city: city)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.onCompletion = { [ weak self ] currentWeather in
            guard let self = self else {return}
            self.updateInterface(with: currentWeather)
        }
        self.networkManager.fetchWeather(city: "Tashkent")
    }
    
    func updateInterface (with weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.temperatureFeelsLikeString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
        
    }
    
    
}

extension ViewController {
    func showSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping(String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["London", "Moscow", "New York", "Stambul", "Tashkent"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler (city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}
