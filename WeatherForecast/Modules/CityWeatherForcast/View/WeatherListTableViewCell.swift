//
//  WeatherListTableViewCell.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-03-03.
//

import UIKit
import SVGKit


class WeatherListTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet private weak var imageViewIcon: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherState: UILabel!
    @IBOutlet private weak var maxTemp: UILabel!
    @IBOutlet private weak var minTemp: UILabel!
    
    var customView = CustomView()
    
    private var urlString: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCellWithValuesOf(with data :ConsolidatedWeather) {
        let temp = (String(format: "%.2fºC ", data.theTemp))
        let weatherState = data.weatherStateName
        let maxTemp = (String(format: "%.2fºC ", data.maxTemp))
        let minTemp = (String(format: "%.2fºC ", data.minTemp))
        updateUI(temperature: temp, weatherState: weatherState, maxTemp: maxTemp, minTemp: minTemp, icon: data.weatherStateAbbr)
    }
    
    //MARK: Update the UI Views
    private func updateUI(temperature: String, weatherState: String, maxTemp: String, minTemp: String, icon: String) {
        self.temperatureLabel?.text = temperature
        self.weatherState.text = weatherState
        self.maxTemp.text = maxTemp
        self.minTemp.text = minTemp
        
        // Before we download the image we clear out the old one
        self.imageViewIcon.image = nil
        getImageDataFrom(weatherIamgeIcon: icon)
        customView.customView(userview: cardView)
        
        
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(weatherIamgeIcon: String) {
        
        let urlString = "\(urlBase.imageUrl.rawValue)\(weatherIamgeIcon)\(urlBase.imageType.rawValue)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let posterImageURL = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: posterImageURL) { (data, response, error) in
            // Handle Error
            
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                let receivedimage: SVGKImage = SVGKImage(data: data)
                self.imageViewIcon.image = receivedimage.uiImage
            }
        }.resume()
    }
    
}
