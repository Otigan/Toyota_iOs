//
//  RepairViewController.swift
//  SlideInTransition
//
//  Created by otigan on 26.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class RepairViewController: UIViewController {

    
    
    let mastersList = MastersTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                        
                   //let text = UILabel(frame: CGRect(x:100, y:100, width:100, height:50))
                   //text.text = "Masters"
                   //view.addSubview(text)
        
       
        
        setup()
    }
    
    
    func setup() {
        addChild(mastersList)
        self.view.addSubview(mastersList.view)
        
        mastersList.didMove(toParent: self)
        
        mastersList.view.frame = self.view.bounds
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
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
