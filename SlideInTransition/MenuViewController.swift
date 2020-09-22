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
}

class MenuViewController: UITableViewController {
   
    
    
    @IBOutlet weak var loginCell: UITableViewCell!
    
    
    
    
    @IBAction func gotoLoginClick(_ sender: UIButton) {
        
        print("CLICKED")
        
        //let story = UIStoryboard(name: "Main", bundle: nil)
        //let controller = story.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        
        //let navigation = UINavigationController(rootViewController: controller)
        
        //self.view.addSubview(navigation.view)
        //self.addChild(navigation)
        //navigation.didMove(toParent: self)
    }
    
    var didTapMenuType: ((MenuType) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //loginCell.isUserInteractionEnabled = false
        //Do any additional setup after loading the view.
    }
    


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        
        
        
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
}
