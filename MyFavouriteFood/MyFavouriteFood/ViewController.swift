//
//  ViewController.swift
//  MyFavouriteFood
//
//  Created by Ting Liu on 9/26/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource{
    
    
    let foods = ["beer","cake","chicken","honey","ice cream","milk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: view.bounds,style: .plain)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = foods[indexPath.row];
            return cell
        }
        return UITableViewCell()
    }
}
