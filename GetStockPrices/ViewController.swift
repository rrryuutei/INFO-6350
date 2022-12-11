//
//  ViewController.swift
//  GetStockPrices
//
//  Created by TingLiu on 10/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

let allStockAPI = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/allstocks"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var allStock:JSON = []

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllStock()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStock.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = allStock[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(object["CompanyName"]) (\(object["Symbol"])): \(object["Price"])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        // Send the symbol  to next VC
        let object = allStock[indexPath.row]
        performSegue(withIdentifier: "segueDetails", sender: ["symbol":object["Symbol"].stringValue])
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetails" {
            let vc = segue.destination as! DetailsViewController
            let object = sender as! [String: String]
            vc.symbol = object["symbol"]
        }
    }
    
    func getAllStock()  {
        SwiftSpinner.show("Loading")
        AF.request(allStockAPI).validate().responseJSON { response in
            SwiftSpinner.hide()
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.allStock = json
                self.tblView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

