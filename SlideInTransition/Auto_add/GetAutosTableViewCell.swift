//
//  TableViewCell.swift
//  SlideInTransition
//
//  Created by otigan on 05.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class GetAutosTableViewCell: UITableViewCell {

    var modelAutoImage = UIImageView()
       
    var modelAutoName = UILabel()
    
  

       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           addSubview(modelAutoImage)
        
        
           addSubview(modelAutoName)
           
           configureImageView()
           configureAutoNameView()
        
        
           //setImageConstraints()
           setAutoNameLabelConstraints()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
       func configureImageView() {
        modelAutoImage.layer.cornerRadius = 10
        modelAutoImage.clipsToBounds = true
       }
    
    func configureAutoNameView() {
        modelAutoName.numberOfLines = 0
        modelAutoName.adjustsFontSizeToFitWidth = true
    }
       
       func setImageConstraints() {
        
        
        
           modelAutoImage.translatesAutoresizingMaskIntoConstraints = false
           modelAutoImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           modelAutoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
           modelAutoImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
           modelAutoImage.widthAnchor.constraint(equalTo: modelAutoImage.heightAnchor, multiplier: 16/9).isActive = true
       }
    
    
    func setAutoNameLabelConstraints() {
        modelAutoName.translatesAutoresizingMaskIntoConstraints = false
           modelAutoName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           modelAutoName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
           modelAutoName.heightAnchor.constraint(equalToConstant: 80).isActive = true
        modelAutoName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
          
        
    }


}
