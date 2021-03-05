//
//  LocationViewModel.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-02-28.
//

import Foundation

class SearchCityDataViewModel{
    private var networkManager = SearchCityNetworkManager()
    var cityDataSource = [CityDataModel]()
    
    func getCityData(query: String, completion: @escaping () -> ()) {      
        networkManager.getCityDataNetworkCall(queryFor: query) { [weak self](result) in
            switch result{
            case .success(let information):
                //print("information: \(information)")
                self?.cityDataSource = information
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if cityDataSource.count != 0 {
            return cityDataSource.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> CityDataModel {
        return cityDataSource[indexPath.row]
    }

    func numberOfRows(inSection section: Int) -> Int {
        return cityDataSource.count
    }
    
    func didSelect(at indexPath: Int) -> CityDataModel {
        return cityDataSource[indexPath]
    }
}
