//
//  ViewController.swift
//  SlideInTransition
//
//  Created by Gary Tokman on 1/12/19.
//  Copyright © 2019 Gary Tokman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let transiton = SlideInTransition()
    var topView: UIView?
    
    let loginVC = LoginController()
    var check:Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        
        if check == true {
           
            
            addChild(loginVC)
            //loginVC.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(loginVC.view)
            
            
            //NSLayoutConstraint.activate([
           // loginVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
           // loginVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
           //loginVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            //loginVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
           // ])
            
            loginVC.didMove(toParent: self)
        } else if check == false {
            for view in self.view.subviews {
                view.removeFromSuperview()
            }
            
            print("check remove")
            
        }
        
        
                
        
         
    }

    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }

    func transitionToNew(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title

        topView?.removeFromSuperview()
        switch menuType {
        case .login:
           // let view = UIView()
                  //    view.backgroundColor = .blue
                   //   view.frame = self.view.bounds
                   //   self.view.addSubview(view)
                   //   self.topView =
            check = true
            viewDidLoad()

            
            
        case .услуги:
            check = false
            viewDidLoad()
            let view = UIView()
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
            let buttonRepair = UIButton(frame: CGRect(x:100, y:100, width:100, height:50))
            
            buttonRepair.setTitle("Ремонт", for: .normal)
            buttonRepair.setTitleColor(.black, for: .normal)
            view.addSubview(buttonRepair)
            
        case .контакты:
            check = false
            viewDidLoad()
            let view = UIView()
            //view.backgroundColor = .blue
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
            
            let text = UILabel(frame: CGRect(x:100, y:100, width:100, height:50))
            text.text = "Contacts"
            view.addSubview(text)
            
        default:
            break
        }
    }

}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}

