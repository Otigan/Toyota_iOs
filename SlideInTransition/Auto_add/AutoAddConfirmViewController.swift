//
//  AutoAddConfirmViewController.swift
//  SlideInTransition
//
//  Created by otigan on 06.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit



protocol ConfirmAddingAuto: class {
    func confirmAddingAuto(_ sender: Any)
}

class AutoAddConfirmViewController: UIViewController {
    
    
    @IBOutlet weak var modelName: UITextField!
    
    
    
    @IBOutlet weak var mileage: UITextField!
    
    
    @IBOutlet weak var vinField: UITextField!
    

    @IBOutlet weak var issueYear: UITextField!
    
    
    
    @IBOutlet weak var addAutoButton: UIButton!
    
    
    
    
    
     let modelNameString = UserDefaults.standard.value(forKey: "selectedModelName") as! String
           
           let mileageString = UserDefaults.standard.value(forKey: "selectedMileage") as! String
           
           let vinString = UserDefaults.standard.value(forKey: "selectedVIN") as! String
           
           let issueYearString = UserDefaults.standard.value(forKey: "selectedIssueYear") as! String
    
    let modelImage = UserDefaults.standard.value(forKey: "selectedModelImage") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        modelName.text = modelNameString
        mileage.text = mileageString
        vinField.text = vinString
        issueYear.text = issueYearString
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func addAuto(_ sender: Any) {
        let url = "http://toyotarest.ru/api/add_auto"
        
        let urll = URL(string: url)!
        
        let parameters = ["name": modelNameString, "year_of_issue": issueYearString, "mileage": mileageString, "vin": vinString, "auto_image": modelImage]
        
        
        var request = URLRequest(url: urll)
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        
        request.httpBody = httpBody
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) {(data, response, error) in
            
            if let response = response {
                print(response)
            
            }
            
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(SuccessResponse.self, from: data)
                
                print(json.message)
                
                
            } catch {
                print(error)
            }
        }.resume()
        
        navigationController?.popToRootViewController(animated: true)
        
        
        
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

// MARK: - SuccessResponse
struct SuccessResponse: Codable {
    let message: String
}
