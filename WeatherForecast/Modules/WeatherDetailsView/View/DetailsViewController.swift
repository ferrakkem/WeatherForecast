//
//  DetailsViewController.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-03-03.
//

import UIKit
import MapKit
import SVGKit

class DetailsViewController: UIViewController {
    var detailsViewModel = DetailsWeatherViewModel()
    var weatherData: ConsolidatedWeather?
    @IBOutlet weak var theTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsViewModel.dipTapDataSet(data: weatherData!)
        detailsViewModel.attachView(self)
        
    }
    
}


extension DetailsViewController: DetailsWeatherDelegate{
    func setupIcon(iconImage: String) {
        self.iconImageView?.image = UIImage(named: iconImage) ?? UIImage()
    }
    
    func setupDate(date: String) {
        self.dateLabel?.text = date
    }
    
    func setupCityName(city: String) {
        print(city)
    }
    
    func setupRain(rain: String) {
        self.rainLabel?.text = rain
    }
    
    func setupWind(wind: String) {
        self.windLabel?.text = wind
    }
    
    func setupHumidity(humidity: String) {
        self.humidityLabel?.text = humidity
    }
    
    func setupTempLabel(actualTemp: String, maxTemp: String, minTemp: String, weatherSate: String) {
        self.theTempLabel?.text = actualTemp
        self.maxTempLabel?.text = maxTemp
        self.minTempLabel?.text = minTemp
        self.weatherStateLabel.text = weatherSate
        
    }
    
    func addCityPinToMap(latitude: Double, longitude: Double, city: String) {
        let pinMap = CreatePin(
            title: city,
            coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        mapView?.addAnnotation(pinMap)
    }
    
    
}
