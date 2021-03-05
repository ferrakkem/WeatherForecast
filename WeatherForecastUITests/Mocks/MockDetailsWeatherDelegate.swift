//
//  MockDetailsWeatherDelegate.swift
//  WeatherForecastUITests
//
//  Created by Ferrakkem Bhuiyan on 2021-03-05.
//

import Foundation
@testable import WeatherForecast

class MockDetailsWeatherDelegate: DetailsWeatherDelegate{
    var isSetupIcon: Bool = false
    var isSetupDate: Bool = false
    var isSetupCityName: Bool = false
    var isSetupRain: Bool = false
    var isSetupWind: Bool = false
    var isSetupHumidity: Bool = false
    var isSetupTempLabel: Bool = false
    var isaAdCityPinToMap: Bool = false
    
    func setupIcon(iconImage: String) {
        isSetupIcon = true
    }
    
    func setupDate(date: String) {
        isSetupDate = true
    }
    
    func setupCityName(city: String) {
        isSetupCityName = true
    }
    
    func setupRain(rain: String) {
        isSetupRain = true
    }
    
    func setupWind(wind: String) {
        isSetupWind = true
    }
    
    func setupHumidity(humidity: String) {
        isSetupHumidity = true
    }
    
    func setupTempLabel(actualTemp: String, maxTemp: String, minTemp: String, weatherSate: String) {
        isSetupTempLabel = true
    }
    
    func addCityPinToMap(latitude: Double, longitude: Double, city: String) {
        isaAdCityPinToMap = true
    }
    
    
}
