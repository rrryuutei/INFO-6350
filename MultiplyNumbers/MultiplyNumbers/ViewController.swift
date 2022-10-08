//
//  ViewController.swift
//  MultiplyNumbers
//
//  Created by 621design on 2022/9/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var firstF: UITextField!
    
    @IBOutlet weak var secondF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func resultClick(_ sender: Any) {
        if let text1 = firstF.text, let text2 = secondF.text, let value1 = Int(text1), let value2 = Int(text2){
            let result = value1 * value2
            resultLabel.text = "\(result)"
        }
    }
}

