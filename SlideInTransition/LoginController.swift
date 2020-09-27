//
//  LoginController.swift
//  SlideInTransition
//
//  Created by otigan on 18.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit
import Foundation


class LoginController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    
    @IBAction func close() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var passField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func pressedLogin(_ sender: Any) {
        
        
        let email = emailField.text
        let pass = passField.text
        
        if email != nil && pass != nil {
            
    
            if !email!.isEmpty && !pass!.isEmpty  {
                
                let email = emailField.text
                let pass = passField.text
                
                let url = "http://toyotarest.ru/api/login"
                
                //getData(from: url)
                
                getJSON(from: url, email: email!, password: pass!)
                
                close()
               
            }
            
        } else {
            
        }
    }
    
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the
        
       
                    
        
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
                
            
          
                
            } catch {
                print(error)
            }
        }.resume()
        

    
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
