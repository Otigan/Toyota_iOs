//
//  ServicesListTableCell.swift
//  SlideInTransition
//
//  Created by otigan on 25.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class ServicesListTableCell: UITableViewCell {
    
    
    let serviceName = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     
        addSubview(serviceName)
        
        configureServiceName()
        setServiceNameLabelConstraints()
     
     
        //setImageConstraints()
        //setAutoNameLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
    
    func configureServiceName() {
        serviceName.numberOfLines = 0
        serviceName.adjustsFontSizeToFitWidth = true
    }
    
      func setServiceNameLabelConstraints() {
          serviceName.translatesAutoresizingMaskIntoConstraints = false
             serviceName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
             serviceName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
             serviceName.heightAnchor.constraint(equalToConstant: 80).isActive = true
          serviceName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
            
          
      }
}
