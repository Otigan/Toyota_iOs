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
    
    
    @IBOutlet weak var passField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func pressedLogin(_ sender: Any) {
        
        
        let email = emailField.text
        let pass = passField.text
        
        if email != nil && pass != nil {
            
    
            if !email!.isEmpty && !pass!.isEmpty  {
                
                let email = emailField.text
                let pass = passField.text
                
                let url = "http://toyotarest.ru/api/login?email=" + email! + "&password=" + pass!
                
                getData(from: url)
                
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
    
   
    private func getData(from url:String) {
        
        let session = URLSession(configuration: .default)
        
        guard let url_login = URL(string : url) else {
            print("Can't create URL")
            
            return
        }
        
        
        let task = session.dataTask(with: URLRequest(url: url_login)) {
            (data, response, error) in
            
            guard let data = data, error == nil else {
                print("Error")
                
                return
            }
            
            var result: LoginSuccess?
            do {
                result = try JSONDecoder().decode(LoginSuccess.self, from: data)
            } catch {
                print("Error decoding \(error.localizedDescription)")
                
            }
            
            guard let json = result else {
                return
            }
            
            print(json.token)
            
        }
    
        task.resume()
    }
    
    // MARK: - LoginSuccess
    struct LoginSuccess: Codable {
    let success, name, tokenType, token: String
    let expiresAt: String

        enum CodingKeys: String, CodingKey {
        case success, name
        case tokenType = "token_type"
        case token
        case expiresAt = "expires_at"
        }
    }
}
