//
//  WeatherCell.swift
//  TWeather
//
//  Created by Ting Liu on 2022/11/20.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "1111"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var conditionLabel: UILabel = {
        let label = UILabel()
        label.text = "33333"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(self.tempLabel)
        self.contentView.addSubview(self.conditionLabel)
        
        self.tempLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15).isActive = true
        self.tempLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        self.conditionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15).isActive = true
        self.conditionLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
