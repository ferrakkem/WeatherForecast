//
//  File.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-03-04.
//

import Foundation
import MapKit

protocol DetailsWeatherDelegate {
    func setupIcon(iconImage: String)
    func setupDate(date: String)
    func setupCityName(city: String)
    func setupRain(rain: String)
    func setupWind(wind: String)
    func setupHumidity(humidity: String)
    func setupTempLabel(actualTemp: String, maxTemp: String, minTemp: String, weatherSate: String)
    func addCityPinToMap(latitude: Double, longitude: Double, city: String)
}

class DetailsWeatherViewModel{
    
    var delegate: DetailsWeatherDelegate?
    private var search: CityDataModel?
    var weatherData: ConsolidatedWeather?
    
    
    func dipTapDataSet(data :ConsolidatedWeather) {
        weatherData = data
    }
    
    //MARK: - init
    func attachView(_ delegate: DetailsWeatherDelegate) {
        print("attachView")
        self.delegate = delegate
        setupIconAndLabels()
        setupDetails()
        setupTemp()
        didCenterToLocation()
    }
    
    private func setupIconAndLabels() {
        delegate?.setupIcon(iconImage: weatherData!.weatherStateAbbr)
        delegate?.setupDate(date: convertDate(date: weatherData!.created))
    }
    
    private func setupTemp() {
        let actualTemp = (String(format: "%.0fºC", weatherData!.theTemp))
        let maxTemp = (String(format: "%.0fºC ", weatherData!.maxTemp))
        let minTemp = (String(format: "%.0fºC ", weatherData!.minTemp))
        let weatherSate = (weatherData!.weatherStateName)
        delegate?.setupTempLabel(actualTemp: actualTemp, maxTemp: maxTemp, minTemp: minTemp, weatherSate: weatherSate)
    }
    
    private func setupDetails() {
        delegate?.setupRain(rain: String("\(weatherData!.predictability)%"))
        delegate?.setupWind(wind: String(format: "%.0f km/h ", weatherData!.windSpeed))
        delegate?.setupHumidity(humidity: String("\(weatherData!.humidity)%"))
    }
    
    func didCenterToLocation() {
        delegate?.addCityPinToMap(latitude: 43.6532,longitude: -79.3832,city: "Toronto")
    }
    
    func convertDate(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        // This is important - we set our input date format to match our input string
        // if the format doesn't match you'll get nil from your string, so be careful
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        //`date(from:)` returns an optional so make sure you unwrap when using.
        let dateFromString: Date? = dateFormatter.date(from: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MMM-dd"
        
        //Using the dateFromString variable from before.
        let stringDate: String = formatter.string(from: dateFromString!)
        
        return stringDate
        
    }
}






