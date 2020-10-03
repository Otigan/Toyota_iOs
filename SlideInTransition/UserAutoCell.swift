//
//  UserAutoCell.swift
//  SlideInTransition
//
//  Created by otigan on 30.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class UserAutoCell: UITableViewCell {

    var userAutoImage = UIImageView(frame: CGRect(x:0, y:0, width: 50, height: 150))
       
       

       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           addSubview(userAutoImage)
           
           configureImageView()
           setImageConstraints()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
       func configureImageView() {
        userAutoImage.layer.cornerRadius = 10
        userAutoImage.clipsToBounds = true
       }
       
       func setImageConstraints() {
        
        
        
           userAutoImage.translatesAutoresizingMaskIntoConstraints = false
           userAutoImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           userAutoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80).isActive = true
           userAutoImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
           userAutoImage.widthAnchor.constraint(equalTo: userAutoImage.heightAnchor, multiplier: 16/9).isActive = true
       }

}
