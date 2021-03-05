//
//  FiveDaysForcastViewController.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-03-03.
//

import UIKit
class WeatherListViewController: UIViewController {
    
    var cityId: Int = 0
    @IBOutlet weak var weatherListTableView: UITableView!
    private var weatherViewModel = WeatherViewModel()
    
    var index: ConsolidatedWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeather()
        setUpTableView()
    }
    
    func setUpTableView(){
        weatherListTableView.register(UINib(nibName: K.WeatherList.cellNibName, bundle: nil), forCellReuseIdentifier: K.WeatherList.cellIdentifier)
        weatherListTableView.separatorStyle = .none
        weatherListTableView.reloadData()
    }
    
    func loadWeather(){
        weatherViewModel.getCityData(woid: cityId) {
            DispatchQueue.main.async {
                self.weatherListTableView.reloadData()
            }
        }
    }
    
    @IBAction func FivedaysForcast(_ sender: Any) {
        performSegue(withIdentifier: K.FiveDaysForcast.segueIndentifier, sender: self)
    }
    
}


//MARK: - TableView Delegate
extension WeatherListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = weatherViewModel.numberOfRowsInSection(section: section)
    
        if data == 0{
            self.weatherListTableView.setEmptyMessage("Nothing to show :(")
        }else{
            self.weatherListTableView.restore()
        }
        
        return data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherListTableView.dequeueReusableCell(withIdentifier: K.WeatherList.cellIdentifier, for: indexPath) as! WeatherListTableViewCell
        let weatherInfo = weatherViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(with: weatherInfo)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = weatherViewModel.didSelect(at: indexPath.row)
        performSegue(withIdentifier: K.DetailsView.segueIndentifier, sender: self)
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == K.DetailsView.segueIndentifier) {
            let destinationVc = segue.destination as! DetailsViewController
            destinationVc.weatherData = index

        }
    }
}
