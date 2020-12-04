//
//  ShopViewController.swift
//  SlideInTransition
//
//  Created by otigan on 10.11.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit
import MaterialComponents


class ShopViewController: UIViewController, MDCTabBarViewDelegate, UIScrollViewDelegate, MDCBottomNavigationBarDelegate {

    
    
    //let tabBar = MDCTabBarView(frame: CGRect(x: 0, y: 80, width: 414, height: 400))
    
    //let bottom = MDCBottomDrawerViewController()
    
    
    var shop: AllAutosShop!
    
    var bottomNav: MDCBottomNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let safe = view.safeAreaInsets.top
        
        
        bottomNav = MDCBottomNavigationBar(frame: CGRect(x: 0, y: 100 , width: view.frame.size.width, height: 50))
        

        
        bottomNav.barTintColor = .red
        
        
        let item = UITabBarItem(title: "new autos", image: nil, tag: 0)
        
        let item1 = UITabBarItem(title: "old autos", image: nil, tag: 1)
        
        bottomNav.delegate = self
        
        bottomNav.items = [item, item1]
        
        bottomNav.selectedItem = bottomNav.items[0]
        
        view.addSubview(bottomNav)
        
        
        shop = AllAutosShop(mode: item.title!)
        
        shop.view.frame = CGRect(x: 50, y: 150, width: view.frame.size.width, height: view.frame.size.height)
        
        self.view.addSubview(shop.view)
        
        self.addChild(shop)
    
        shop.didMove(toParent: self)
        
        let top = self.presentingViewController
        
        
        let swipeLeft = UISwipeGestureRecognizer()
        
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer()
        
        swipeRight.direction = .right
        
        shop.view.addGestureRecognizer(swipeLeft)
        shop.view.addGestureRecognizer(swipeRight)
        
        swipeLeft.addTarget(self, action: #selector(swipeDetection(sender:)))
        
        swipeRight.addTarget(self, action: #selector(swipeDetection(sender:)))
        
    }
    
    @objc func swipeDetection(sender: UISwipeGestureRecognizer) {
        
        let list = bottomNav.items
        
        let size = list.count
        
        let index = list.firstIndex(of: bottomNav.selectedItem!)
        
        
        switch sender.direction {
        case .left:

            if index! != size - 1 {
                self.bottomNavigationBar(bottomNav, didSelect: list[index! + 1])
            }
            
        case .right:
            if index! != 0 {
                self.bottomNavigationBar(bottomNav, didSelect: list[index! - 1	])
            }
            

        default:
            print("")
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        
        super.viewDidLayoutSubviews()
    
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        
        
        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        
        
    }
    
    
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
   
        bottomNav.selectedItem = item
        
        shop.update(mode: item.title!)
        
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
