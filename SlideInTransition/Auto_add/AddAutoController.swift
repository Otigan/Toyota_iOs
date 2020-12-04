//
//  AddAutoController.swift
//  SlideInTransition
//
//  Created by otigan on 05.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit


class AddAutoController: UIViewController, ModelSelect, UIPickerViewDelegate, UIPickerViewDataSource, MileageEnter {
    
    
    var models: GetAutosTableViewController?
    
    var mileageVC: MileageEnterViewController?
    
    
  
   
     
    
    
    func mileageEntered(_ sender: Any) {
        
         UserDefaults.standard.set(mileageVC?.mileageField.text, forKey: "selectedMileage")
        let autoAddConf = storyboard?.instantiateViewController(withIdentifier: "AutoAddConfirmViewController") as! AutoAddConfirmViewController
        
        
       
        

        navigationController?.pushViewController(autoAddConf, animated: true)
    }
    
    
    
            let yearsOfIssue = ["2000", "2001", "2002"]
    
    


    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        UserDefaults.standard.set(yearsOfIssue[row], forKey: "selectedIssueYear")
        
        return yearsOfIssue[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearsOfIssue.count
    }
    
    
    
    
    func didSelectAutoModel(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        vc.view.addSubview(pickerView)
        
        let editRadiusAlert = UIAlertController(title: "Choose distance", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: {action in
            
            
            let modelName = self.models?.autoModels[indexPath.row].name
            
            let modelImage = self.models?.autoModels[indexPath.row].modelImage
            
            UserDefaults.standard.set(modelImage, forKey: "selectedModelImage")
            
            UserDefaults.standard.set(modelName, forKey: "selectedModelName")
            
           
            self.mileageVC = self.storyboard?.instantiateViewController(withIdentifier: "MileageEnterViewController") as? MileageEnterViewController
            
            self.mileageVC?.delegate = self
            
            self.navigationController?.pushViewController(self.mileageVC!, animated: true)
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
        
        
        
    }
    
 
    
    
    var vinEnterController: VinEnterViewController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        vinEnterController = (self.storyboard?.instantiateViewController(withIdentifier: "VinEnterViewController") as! VinEnterViewController)
        
        setup()
        
        self.title = "Enter VIN"

        vinEnterController?.errorVIN.isHidden = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(gotoAutoList))
        
    }
    
    
    func setup() {
    
        
        addChild(vinEnterController!)
        
        self.view.addSubview(vinEnterController!.view)
        
        vinEnterController!.didMove(toParent: self)
        
        vinEnterController!.view.frame = self.view.bounds
    }
    
    
    @objc func gotoAutoList() {
        
        let vinText = vinEnterController!.vinEnterField.text
        
        if vinText!.isEmpty {
            
            vinEnterController?.errorVIN.isHidden = false
            
            vinEnterController?.errorVIN.text = "Заполните это поле"
            
        } else if vinText!.count < 17 {
            
            vinEnterController!.errorVIN.isHidden = false
            
            vinEnterController?.errorVIN.text = "Регистрационный номер должен содержать 17 символов"
            
        } else {
            
            UserDefaults.standard.set(vinText!, forKey: "selectedVIN")
            
            vinEnterController?.errorVIN.isHidden = true
            
              models = GetAutosTableViewController()
                  
            
                models!.delegate = self
                  
                  navigationController?.pushViewController(models!, animated: true)
            
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

