//
//  ViewController.swift
//  weather
//
//  Created by Bumsang Kim on 2022/01/27.
//

import UIKit

let openWeatherAPIKey = "9e747083fd37579acac6b0e80a576b1d"

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temporatureLabel: UILabel!
    @IBOutlet weak var maxTemporatureLabel: UILabel!
    @IBOutlet weak var minTemporatureLabel: UILabel!
    
    @IBOutlet weak var weatherStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapFatchWeatherButton(_ sender: UIButton) {
        guard let cityName = self.cityNameTextField.text else { return }
        getCurrentWeather(cityName: cityName)
        self.view.endEditing(true)
    }
    
    func getCurrentWeather(cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(openWeatherAPIKey)") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.weatherStackView.alpha = 0
                    })
                    self?.configureView(weatherInformation: weatherInformation)
                    UIView.animate(withDuration: 0.4, animations: {
                        self?.weatherStackView.alpha = 1
                    })
                }
            }
            else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.showAlert(message: errorMessage.message)
                }
            }
        }).resume()
    }
    
    func configureView(weatherInformation: WeatherInformation) {
        self.cityNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first {
            self.weatherDescriptionLabel.text = weather.description
        }
        self.temporatureLabel.text = "\(Int(weatherInformation.temporature.temporature-273.15))℃"
        self.maxTemporatureLabel.text = "최고: \(Int(weatherInformation.temporature.maxTemporature-273.15))℃"
        self.minTemporatureLabel.text = "최저: \(Int(weatherInformation.temporature.minTemporature-273.15))℃"
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

