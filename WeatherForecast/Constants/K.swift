//
//  K.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-02-28.
//

import Foundation

struct K{
    //MARK: - For currentCity Table
    struct CurrentCity {
        static let cellNibName = "SearchCityTableViewCell"
        static let cellIdentifier = "searchCityCell"
    }
    struct WeatherList{
        static let segueIndentifier = "weatherList"
        static let cellNibName = "WeatherListTableViewCell"
        static let cellIdentifier = "weatherListCell"
    }
    
    struct DetailsView{
        static let segueIndentifier = "detailsViews"
    }
    
    struct FiveDaysForcast{
        static let segueIndentifier = "FivedaysForcast"
    }
    
}



enum urlBase: String {
    case metaWeather = "https://www.metaweather.com/api/location/"
    case searchQuery = "search/?query="
    case searchLatLog = "search/?lattlong="
    case imageUrl = "https://www.metaweather.com/static/img/weather/"
    case imageType = ".svg"
}
