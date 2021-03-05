//
//  CurrentCityTableViewCell.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-03-02.
//

import UIKit

class SearchCityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Setup News values online Data
    func setCellWithValuesOf(with data :CityDataModel) {
        updateUI(cityName: data.title, cityId: data.woeid)
    }
    
    //MARK: Update the UI Views
    private func updateUI(cityName: String, cityId: Int) {
        self.cityName.text = cityName
        self.cityId.text = String(cityId)
    }
    
}
