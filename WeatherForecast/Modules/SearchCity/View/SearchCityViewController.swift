//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Ferrakkem Bhuiyan on 2021-02-27.
//

import UIKit
import CoreLocation

class SearchCityViewController: UIViewController {
    
    private var cityDataViewModel = SearchCityDataViewModel()
    private var data = [CityDataModel]()
    @IBOutlet weak var searchCityListTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var locationManager = CLLocationManager()
    
    var woeid = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Forcast"
        setUpLocationManager()
        LoadingStart(messsage: "Getting location")
        searchCityListTableView.delegate = self
        do{
            sleep(2)
            setUpTableView()
        }
    }
    
    func setUpTableView(){
        searchCityListTableView.register(UINib(nibName: K.CurrentCity.cellNibName, bundle: nil), forCellReuseIdentifier: K.CurrentCity.cellIdentifier)
        searchCityListTableView.separatorStyle = .none
        searchCityListTableView.reloadData()
    }
    
    
    private func setUpLocationManager(){
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    //MARK: -FiveDayForcastBtnPressed
    @IBAction func RefereshBtnPressed(_ sender: Any) {
        LoadingStart(messsage: "Refreshing....")
        let lat = 43.6532
        let long = -79.3832
        let lattlong = "\(urlBase.searchLatLog.rawValue)\(lat),\(long)"
        cityDataViewModel.getCityData(query: lattlong) {[weak self] in
            DispatchQueue.main.async {
                self?.searchBar.resignFirstResponder()
                self?.LoadingStop()
                self?.searchCityListTableView.reloadData()
            }
        }
    }
}

//MARK: - TableView Delegate
extension SearchCityViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = cityDataViewModel.numberOfRowsInSection(section: section)
        if data == 0{
            self.searchCityListTableView.setEmptyMessage("Nothing to show :(")
        }else{
            self.searchCityListTableView.restore()
        }
        return data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchCityListTableView.dequeueReusableCell(withIdentifier: K.CurrentCity.cellIdentifier, for: indexPath) as! SearchCityTableViewCell
        let cityInformation = cityDataViewModel.cellForRowAt(indexPath: indexPath)
        //print(cityInformation.title)
        cell.setCellWithValuesOf(with: cityInformation)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = cityDataViewModel.didSelect(at: indexPath.row)
        woeid = index.woeid
        performSegue(withIdentifier: K.WeatherList.segueIndentifier, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! WeatherListViewController
        destinationVc.cityId = woeid
    }
    
}

// MARK: CoreLocation Output
extension SearchCityViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loction = locations.last{
            let lat = loction.coordinate.latitude
            let long = loction.coordinate.longitude
            let lattlong = "\(urlBase.searchLatLog.rawValue)\(lat),\(long)"
            cityDataViewModel.getCityData(query: lattlong) {[weak self] in
                self?.LoadingStop()
                self?.searchCityListTableView.reloadData()
            }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager error: \(locationManager)")
    }
}

//MARK: - UISearchBarDelegate
extension SearchCityViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let location = searchBar.text else {
            return
        }
        
        let queryString = "\(urlBase.searchQuery.rawValue)\(location)"
        cityDataViewModel.getCityData(query: queryString) {[weak self] in
            self?.LoadingStop()
            self?.searchCityListTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            //setUpLocationManager()
            data.removeAll()
            searchCityListTableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
