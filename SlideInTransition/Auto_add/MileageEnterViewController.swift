//
//  MileageEnterViewController.swift
//  SlideInTransition
//
//  Created by otigan on 05.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit



protocol MileageEnter: class {
    func mileageEntered(_ sender: Any)
}


class MileageEnterViewController: UIViewController {

    @IBOutlet weak var mileageField: UITextField!
    
    
    
    @IBOutlet weak var confirmMileage: UIButton!
    
    
    weak var delegate: MileageEnter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func enteredMileage(_ sender: Any) {
        
        delegate?.mileageEntered(sender)
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
