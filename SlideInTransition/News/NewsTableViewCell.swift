//
//  NewsTableViewCell.swift
//  SlideInTransition
//
//  Created by otigan on 06.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var newsImage = UIImageView()
         
    var newsTitle = UILabel()
    
    var newsDate = UILabel()
      
    

         override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
             super.init(style: style, reuseIdentifier: reuseIdentifier)
             
            
            addSubview(newsImage)
            addSubview(newsTitle)
            addSubview(newsDate)
             
             configureImageView()
             configureTitleView()
             configureDate()
          
             //setImageConstraints()
             //setTitleConstraints()
         }
         
         required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
         
         
         func configureImageView() {
          newsImage.layer.cornerRadius = 10
          newsImage.clipsToBounds = true
         }
      
      func configureTitleView() {
          newsTitle.numberOfLines = 0
          newsTitle.adjustsFontSizeToFitWidth = true
      }
    
    func configureDate() -> Void {
        newsDate.numberOfLines = 0
        newsDate.adjustsFontSizeToFitWidth = true
    }
         
         func setImageConstraints() {
          
          
          
             newsImage.translatesAutoresizingMaskIntoConstraints = false
             newsImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
             newsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
             newsImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
          
             newsImage.widthAnchor.constraint(equalTo: newsImage.heightAnchor, multiplier: 16/9).isActive = true
         }
      
      
      func setTitleConstraints() {
          newsTitle.translatesAutoresizingMaskIntoConstraints = false
             newsTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
             newsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
             newsTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
          newsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
      }
    
    func setDateConstraints() {
        
        newsDate.translatesAutoresizingMaskIntoConstraints = false
           newsDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           newsDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
           newsDate.heightAnchor.constraint(equalToConstant: 80).isActive = true
        newsDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        
    }

}
