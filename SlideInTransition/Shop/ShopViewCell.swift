//
//  ShopViewCell.swift
//  SlideInTransition
//
//  Created by otigan on 10.11.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class ShopViewCell: UICollectionViewCell {
    
    
    
    var autoName = UILabel()
    
    func configure(auto: String) {
        autoName.text = auto
    }
    
    func setTitleConstraints() {
        
        let myView = UIView()
        
        self.addSubview(myView)
        
        self.backgroundColor = .black
        
        autoName.translatesAutoresizingMaskIntoConstraints = false
           autoName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           autoName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
           autoName.heightAnchor.constraint(equalToConstant: 80).isActive = true
        autoName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        myView.layer.cornerRadius = 20.0
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        myView.layer.shadowRadius = 12.0
        myView.layer.shadowOpacity = 7.0
    }
}
