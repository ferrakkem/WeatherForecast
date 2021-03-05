//
//  CityWeatherNetworkManager.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-03-03.
//

import Foundation

class WeatherNetworkManager{
    private var dataTask: URLSessionDataTask?
    
    func getCityWeatherDataNetworkCall(cityId: Int, completion: @escaping(Result<WeatherModel, Error>) ->Void){
        let urlString = "\(urlBase.metaWeather.rawValue)\(cityId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: urlString) else{
            return
        }
    
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
          "Content-Type": "application/json"
        ]
        
        dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Now Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }

            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(WeatherModel.self, from: data)
                //print("jsonData: \(jsonData)")
                // Back to the main thread
                DispatchQueue.main.async {
                    //print("error***")
                    completion(.success(jsonData))
                }
            } catch let error {
                print("##error")
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    
    }
}
