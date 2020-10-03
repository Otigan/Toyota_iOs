//
//  MastersListCell.swift
//  SlideInTransition
//
//  Created by otigan on 28.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class MastersListCell: UITableViewCell {
    
    
    var cellLabel = UILabel()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellLabel)
        
        configureLabel()
        setLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureLabel() {
        cellLabel.numberOfLines = 0
        cellLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setLabelConstraints() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        cellLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}
