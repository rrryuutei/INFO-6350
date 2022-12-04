//
//  ViewController.swift
//  Tourist
//
//  Created by rrryuutei on 2022/10/3.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let touristPlacesNames = ["The Great Wall","Forbidden City"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TouristCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touristPlacesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TouristCell
        if indexPath.row == 0 {
            cell.photoImageView.image = UIImage(named: "wall")
        }else if indexPath.row == 1 {
            cell.photoImageView.image = UIImage(named: "gugong")
        }
        cell.nameLabel.text = touristPlacesNames[indexPath.row]
        return cell
    }

}

