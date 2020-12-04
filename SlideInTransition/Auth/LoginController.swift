//
//  LoginController.swift
//  SlideInTransition
//
//  Created by otigan on 18.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit
import Foundation


protocol onLogged:class {
    func onLoginPress()
}


class LoginController: UIViewController {

   
    var delegate: onLogged?
    
    
    var success = false
    
    var checkRegister = false
    
    var noAuthRepair = false
    
    
    @IBOutlet weak var emailError: UILabel!
    
    
    
    @IBOutlet weak var passError: UILabel!
    
    
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var passField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func pressedLogin(_ sender: Any) {
        
    
        let emailCheck = validateEmail()
        
        let passCheck = validatePass()
            

            if (emailCheck && passCheck)  {
                
                let email = emailField.text
                let pass = passField.text
                
                let url = "http://toyotarest.ru/api/login"
                
                //getData(from: url)
                
                getJSON(from: url, email: email!, password: pass!)
                
                    
        
            } else {
            
        }
    }
    
    
    
    @IBAction func gotoRegister(_ sender: Any) {
        
        let regVC = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        
        if noAuthRepair {
            
            regVC.noAuthRepair = true
        }
        
        
        navigationController?.pushViewController(regVC, animated: true)
        
        
    }
    
    
    
    
    
    
    func close() {
        
        if noAuthRepair {
            
            let homeVC = navigationController?.viewControllers.first as! HomeViewController
            
            homeVC.fromLoginToServices = true
            
            noAuthRepair = false
        
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the
        
        passField.isSecureTextEntry = true
        
        
        
                    
        
    }
    
    private func getJSON(from url:String, email: String, password: String) {
        
        
        let urll = URL(string: url)!
        
        let parameters = ["email": email, "password": password]
        
        var request = URLRequest(url: urll)
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) {(data, response, error) in
            
            if let response = response {
                print(response)
            
            }
            
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(LoginSuccess.self, from: data)
                
                print(json.token)
                
                UserDefaults.standard.set(json.token, forKey: "token")
                
                UserDefaults.standard.set(json.name, forKey: "username")
          
                
                
                DispatchQueue.main.async {
                    self.close()
                }
                
            } catch {
                print(error)
                
                self.success = false
            }
        }.resume()
        
    }
    
    func validateEmail() -> Bool {
        
        let emailText = emailField.text!
        
        if emailText.isEmpty {
            
            
            emailError.text =  "Введите вашу почту"
            emailError.textColor = .red
            
            return false
        } else {
            
            emailError.textColor = .black
            emailError.text = ""
            
            
            return true
        }
    }
    
    func validatePass() -> Bool {
        
        let passText = passField.text!
        
        if passText.isEmpty {
            
            passError.textColor = .red
            passError.text = "Введите пароль"
            return false
            
        } else {
            passError.textColor = .black
            passError.text = ""
            return true
        }
    }
   

    
    // MARK: - LoginSuccess
    
    struct LoginSuccess : Codable {
        var success: String
        var name: String
        var token_type: String
        var token: String
        var expires_at: String
    }
 
    struct User : Codable {
        let id: Int
        let title: String
        let body: String
        
    }
}
