//
//  RepairViewController.swift
//  SlideInTransition
//
//  Created by otigan on 26.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class RepairViewController: UIViewController, didTapDelegate, ActionDelegate, didSelectAutoDelegate{

    
    
    var autoSelected: Bool?
    
    var autoRepairSelect: AutoRepairSelectVC?
    
    var autoID: Int?
    
    var masterID: Int?
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! UserAutoCell
        
        print(cell.userAutoImage.isAnimating)
        
        autoID = cell.autoID
        
        navigationController?.popViewController(animated: false)
        
        autoRepairSelect!.autoSelectField.text = cell.userAutoName.text
        
        
        
    }
    
 
    
    
    
    
    
    func actionSender(_ sender: Any, didRecieveAction action: DelegateAction) {
        
        
        
        switch action {
        case AutoRepairSelectVC.Action.clickOnAutoSelect:
            
            let userAutos = storyBoard.instantiateViewController(withIdentifier: "UsersAutoTable") as! UsersAutoTable
            
            navigationController?.pushViewController(userAutos, animated: true)
            
            userAutos.delegate = self
            
        case AutoRepairSelectVC.Action.entryConfirm:
            
            let selectedAuto = autoRepairSelect!.autoSelectField.text!
            let selectedTime = autoRepairSelect!.timeSelectField.text!
            
            if !selectedAuto.isEmpty && !selectedTime.isEmpty {
                
                let url = "http://toyotarest.ru/api/add_repairs"
                
                postRepair(from: url, autoID: autoID!, masterID: masterID!, selectedTime: selectedTime)
                
                navigationController?.popToRootViewController(animated: true)
                
                
            } else {
                print("EMPTY")
            }
            
        default:
            print("DELEGATE ERROR")
        }
        
       
        
        
        
    }
    
    
    func postRepair(from url: String, autoID: Int, masterID: Int, selectedTime: String) {
        
        let urll = URL(string: url)!
        
        let parameters = ["auto_id": autoID, "time":selectedTime, "master_id": masterID ] as [String : Any]
        
        var request = URLRequest(url: urll)
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        
        request.httpBody = httpBody
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {return}
        
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) {(data, response, error) in
            
            if let response = response {
                print(response)
            
            }
            
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(AddRepairSuccess.self, from: data)
                
                print(json.message)
          
                
            } catch {
                print(error)
            }
        }.resume()
        

    }
    
    
    
    func masterSelect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(mastersList.masters[indexPath.row].id)
        
        //mastersList.view.removeFromSuperview()
        //mastersList.removeFromParent()
        
        //self.addChild(autoRepairSelect)
        
        //self.view.addSubview(autoRepairSelect.view)
        
        
        //autoRepairSelect.didMove(toParent: self)
        
        //autoRepairSelect.view.frame = self.view.bounds
        
        masterID = mastersList.masters[indexPath.row].id
    
        
        
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


struct AddRepairSuccess : Codable {
    var message: String
}
