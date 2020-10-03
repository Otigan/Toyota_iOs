//
//  AutoRepairSelectVC.swift
//  SlideInTransition
//
//  Created by otigan on 28.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class AutoRepairSelectVC: UIViewController {

    
    
    @IBOutlet weak var autoSelectField: UITextField!
    
    
    @IBOutlet weak var timeSelectField: UITextField!
    
    weak var delegate: AutoSelectTap?
    
    
   
    @IBAction func tapActionSelect(_ sender: UITextField) {
        delegate?.tapOnAutoSelect(sender)
        
        print("zzzzz")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.autoSelectField.isUserInteractionEnabled = false
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

protocol AutoSelectTap: class {
    func tapOnAutoSelect(_ sender: UITextField)
}
