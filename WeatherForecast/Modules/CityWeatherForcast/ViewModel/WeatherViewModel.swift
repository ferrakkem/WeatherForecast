//
//  CityWeatherViewModel.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-03-03.
//

import Foundation


class WeatherViewModel: ObservableObject{
    private var cityWeatherManager = WeatherNetworkManager()
    
    var weatherDataSource = [ConsolidatedWeather]()
    
    //var myStruct :[WeatherModel] = []
        
    @Published var weatherState: String?
    var minTemp: Double?
    var maxTemp: Double?
    var currentTemperature: Double?
    var summary: String?
    var dateString: String = ""
    
    func getCityData(woid: Int, completion: @escaping () -> ()) {
        cityWeatherManager.getCityWeatherDataNetworkCall(cityId: woid) { (result) in
            switch result{
            case .success(let listOfWeather):
                //print("listOfWeather \(listOfWeather)")
                self.weatherDataSource = listOfWeather.consolidatedWeather
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if weatherDataSource.count != 0 {
            return weatherDataSource.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> ConsolidatedWeather {
        return weatherDataSource[indexPath.row]
    }

    func numberOfRows(inSection section: Int) -> Int {
        return weatherDataSource.count
    }
    
    func didSelect(at indexPath: Int) -> ConsolidatedWeather {
        return weatherDataSource[indexPath]
    }
    
        
}
