//
//  RepairViewController.swift
//  SlideInTransition
//
//  Created by otigan on 26.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class RepairViewController: UIViewController, didTapDelegate, AutoSelectTap, didSelectAutoDelegate{
    
    
    var autoSelected: Bool?
    
    var autoRepairSelect: AutoRepairSelectVC?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! UserAutoCell
        
        print(cell.userAutoImage.isAnimating)
        
        
        
        navigationController?.popViewController(animated: false)
        
        autoRepairSelect!.autoSelectField.text = "Selected"
        
    }
    
 
    
    
    
    
    
    func tapOnAutoSelect(_ sender: UITextField) {
        
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "UsersAutoTable") as! UsersAutoTable
        
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    
    func masterSelect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(mastersList.masters[indexPath.row].id)
        
        //mastersList.view.removeFromSuperview()
        //mastersList.removeFromParent()
        
        //self.addChild(autoRepairSelect)
        
        //self.view.addSubview(autoRepairSelect.view)
        
        
        //autoRepairSelect.didMove(toParent: self)
        
        //autoRepairSelect.view.frame = self.view.bounds
        
    
    
        
        
            autoRepairSelect = storyBoard.instantiateViewController(withIdentifier: "AutoRepairSelectVC") as! AutoRepairSelectVC
                   
                   autoRepairSelect!.delegate = self
                   
                   navigationController?.pushViewController(autoRepairSelect!, animated: false)
      
        
       
        
    
    }
    

    
    
    let mastersList = MastersTableViewController()
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                        
                   //let text = UILabel(frame: CGRect(x:100, y:100, width:100, height:50))
                   //text.text = "Masters"
                   //view.addSubview(text)
        
        self.title = "Masters"
        
        //self.navigationController?.navigationBar.topItem?.title = "Masters"
        
        setup()
        
        
    }
    
    
    func setup() {
        addChild(mastersList)
        self.view.addSubview(mastersList.view)
        
        mastersList.delegate = self
        
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
