//
//  CityWeatherModel.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-02-28.
//

import Foundation

// MARK: - CityWeatherModelElement
struct CityDataModel: Codable {
    let title, locationType: String
    let woeid: Int
    let lattLong: String

    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }

}
