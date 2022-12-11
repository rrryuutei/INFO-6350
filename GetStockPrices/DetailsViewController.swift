//
//  DetailsViewController.swift
//  GetStockPrices
//
//  Created by TingLiu on 10/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

let API = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/getstock"

class DetailsViewController: UIViewController {
    
    var symbol:String!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    @IBOutlet weak var stockPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getstock(symbol: self.symbol)
    }
    
    func getstock(symbol:String) {
        let url = "\(API)?symbol=\(symbol)"
        SwiftSpinner.show("Loading")
        AF.request(url).validate().responseJSON { response in
            SwiftSpinner.hide()
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.companyLabel.text = "Company Name: \(json["CompanyName"].stringValue)"
                self.symbolLabel.text = "Company Symbol: \(json["Symbol"].stringValue)"
                self.stockPriceLabel.text = "Stock Price: \(json["Price"].floatValue)$"
            case .failure(let error):
                print(error)
            }
        }
    }

}
