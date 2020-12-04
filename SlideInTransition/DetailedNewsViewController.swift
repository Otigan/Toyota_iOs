//
//  DetailedNewsViewController.swift
//  SlideInTransition
//
//  Created by otigan on 31.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class DetailedNewsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var detailText: UILabel!
    
    
    
    var detailNews: NewsElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        titleLabel.text = "kek"
        
        detailText.numberOfLines = 0
    
        detailText.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        detailText.text = "Lorem ipsum dolor sit er elit lamet, consectetaur a pariatur. E liber te conscient to factor tudasdsdaddasdasdasdsadasdasdasdasdsdadsddsadadsadasdasdasdadadsadasdasdasdasdasdasdasdsadasdsadasdsadadasdasdsadsadadsadasdasdasdsadsadsadasdsadasdsadasdsadadsadsadasdsdsaddsdadsdadsdadsdasdsadadsadsadsadasdasdsdasdsdsadsadsdsfsdafdsfdsfsafsdfsdfdfsdffasdfsdfsfdsfsdfsfsfadfafdfadfdsafsdfsfsafdsafasfsdafdsfsfdsfsdfsafsdafdsfsafsdfsdfsdfsfafsfsdfdsfsdfdsfsdfsfsdfsfsfsfsfsdfsdfsfsdfsdfdsfdsfsadadasdsadsadsdasdasdsddasdadsadadsadadsadasadadm poen legumsdfsafdfafsfsfsdfdfafsadfsafsafsdfsfdfsafsafsafsdafsafsafsafafdas odioquefdsfsfsafsfsfsdfsfsdfsdfsafsafsdfsafsfsdfsfsfsdfsfsf civiuda.dsadasdsadsasadasddasddadsadsddddddddddddd"
        
       
        
        detailText.sizeToFit()
        
        if detailNews != nil {
            
            let url = URL(string: "http://toyotarest.ru/storage/" + detailNews!.image)
                          
            image.sd_setImage(with: url, placeholderImage: UIImage(contentsOfFile: "thumb-jpg.png"))

        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
