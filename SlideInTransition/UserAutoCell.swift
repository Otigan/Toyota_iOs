//
//  UserAutoCell.swift
//  SlideInTransition
//
//  Created by otigan on 30.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class UserAutoCell: UITableViewCell {

    var userAutoImage = UIImageView()
       
    var userAutoName = UILabel()
    
    var autoID: Int?

       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           addSubview(userAutoImage)
        
        
           addSubview(userAutoName)
           
           configureImageView()
           configureAutoNameView()
        
        
           //setImageConstraints()
           //setAutoNameLabelConstraints()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
       func configureImageView() {
        userAutoImage.layer.cornerRadius = 10
        userAutoImage.clipsToBounds = true
       }
    
    func configureAutoNameView() {
        userAutoName.numberOfLines = 0
        userAutoName.adjustsFontSizeToFitWidth = true
    }
       
       func setImageConstraints() {
        
        
        
           userAutoImage.translatesAutoresizingMaskIntoConstraints = false
           userAutoImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           
    
        
           userAutoImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
           userAutoImage.widthAnchor.constraint(equalTo: userAutoImage.heightAnchor, multiplier: 16/9).isActive = true
       }
    
    
    func setAutoNameLabelConstraints() {
        userAutoName.translatesAutoresizingMaskIntoConstraints = false
           userAutoName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           userAutoName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
           userAutoName.heightAnchor.constraint(equalToConstant: 80).isActive = true
        userAutoName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
          
        
    }

}
