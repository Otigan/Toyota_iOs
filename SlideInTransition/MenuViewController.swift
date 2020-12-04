//
//  MenuViewController.swift
//  SlideInTransition
//
//  Created by Gary Tokman on 1/12/19.
//  Copyright © 2019 Gary Tokman. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case login
    case новости
    case услуги
    case контакты
    case автомобили
    case чат
    case магазин
    case профиль
}

class MenuViewController: UITableViewController {
   
    
    
    @IBOutlet weak var loginCell: UITableViewCell!
    
    
    
    @IBOutlet weak var profileCell: UITableViewCell!
    
    
    var username: String?
    
    var token: String?
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var didTapMenuType: ((MenuType) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      tableView.rowHeight = 80
        token = UserDefaults.standard.value(forKey: "token") as? String
        username = UserDefaults.standard.value(forKey: "username") as? String
        
        tableView.reloadData()
        
         if token != nil {
                   if !token!.isEmpty {
                       loginCell.isUserInteractionEnabled = false
                       usernameLabel.text = username!
                   }
               } else {
                   loginCell.isUserInteractionEnabled = true
               }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         
       
    }

    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
                if indexPath.row == 5 {
                    if token == nil {
                        return 0
                    }
                }
            
      
        
        return tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        
        
        
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
}
