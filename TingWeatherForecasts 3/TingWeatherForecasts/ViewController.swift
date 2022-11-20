//
//  ViewController.swift
//  TWeather
//
//  Created by Ting Liu on 2022/11/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

private let WeatherAPI = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations=Herndon.VA.20170&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"

class ViewController: UIViewController {
    var locationGetButton: UIButton!
    var tableView: UITableView!
    var locationTextField: UITextField!
    var getWeatherButton: UIButton!
    var allForestDatas:JSON = []
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setup()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    func setup() {
        locationGetButton = UIButton(type: .custom)
        locationGetButton.setTitle("get Location", for: .normal)
        locationGetButton.addTarget(self, action: #selector(locationClick), for: .touchUpInside)
        self.view.addSubview(locationGetButton)
        locationGetButton.setTitleColor(UIColor.blue, for: .normal)
        locationGetButton.translatesAutoresizingMaskIntoConstraints = false
        locationGetButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        locationGetButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        locationGetButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        locationGetButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        locationTextField = UITextField(frame: .zero)
        locationTextField.placeholder = "location"
        locationTextField.borderStyle = .roundedRect
        self.view.addSubview(locationTextField)
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
         locationTextField.topAnchor.constraint(equalTo: self.locationGetButton.bottomAnchor, constant: 20).isActive = true
         locationTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
         locationTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        getWeatherButton = UIButton(type: .custom)
        getWeatherButton.setTitle("get weather", for: .normal)
        getWeatherButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        getWeatherButton.setTitleColor(UIColor.blue, for: .normal)
        getWeatherButton.addTarget(self, action: #selector(getWeatherClick), for: .touchUpInside)
        self.view.addSubview(getWeatherButton)
        getWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        getWeatherButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getWeatherButton.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 10).isActive = true
        
        tableView = UITableView(frame: .zero, style: .plain);
        tableView.dataSource = self
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        tableView.separatorStyle = .none
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: getWeatherButton.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @objc func getWeatherClick()  {
        AF.request(WeatherAPI).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                self.allForestDatas = json
                self.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    @objc func locationClick()  {
        locationManager.requestLocation()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allForestDatas["locations"]["Herndon.VA.20170"]["values"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherCell
        let value = self.allForestDatas["locations"]["Herndon.VA.20170"]["values"][indexPath.row].dictionaryObject
        cell.tempLabel.text = "temp: " + "\(value?["temp"] as! Double)"
        cell.conditionLabel.text = "conditions: " + "\(value?["conditions"] as! String)" as! String
        return cell
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return}
        let lat = location.coordinate.latitude
        let lng = location.coordinate.longitude

        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

