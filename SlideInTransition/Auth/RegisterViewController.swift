import UIKit


class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    
    
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    

    
    @IBOutlet weak var passField: UITextField!
    
    
    @IBOutlet weak var passErrorLabel: UILabel!
    
    
    
    @IBOutlet weak var passConfField: UITextField!
    
    
    @IBOutlet weak var passConfError: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }
    
    @IBAction func register(_ sender: Any) {
        
        let usernameCheck = validateUsername()
        
        let passCheck = validatePass()
        
        let emailCheck = validateEmail()
        
        let passConfCheck = validateConfPass()
        
        if (usernameCheck && passCheck && emailCheck && passConfCheck) {
            
            print("CLICK REGISTER")
            
    
            let url = "http://toyotarest.ru/api/register"
                   
                   let urll = URL(string: url)!
                   
            let username = nameField.text!
            
            let email = emailField.text!
            
            let pass = passField.text!
            
            let passConf = passConfField.text!
            
            
                   let parameters = ["name": username, "email": email, "password": pass, "password_confirmation": passConf]
                   
                   
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
                           let json = try JSONDecoder().decode(SuccessRegister.self, from: data)
                        
                        
                        print(json.token)
                           
                        UserDefaults.standard.set(json.name, forKey: "username")
                           
                        UserDefaults.standard.set(json.token, forKey: "token")
                           
                       } catch {
                        print(error.localizedDescription)
                       }
                   }.resume()
            
            
            
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    

    
    
    
    func validateUsername() -> Bool {
        if nameField.text!.isEmpty {
            
            nameErrorLabel.text = "Zapolnite eto pole"
            return false
            
        } else {
            nameErrorLabel.text = ""
            
            return true
        }
    }
    
    
    func validateEmail() -> Bool {
        
        let emailText = emailField.text!
        
        if emailText.isEmpty {
            
            emailErrorLabel.text = "Zapolnite"
            
            return false
            
        } else if !emailText.isValidEmail {
            
            emailErrorLabel.text = "NERPAVILNAA"
            
            return false
        } else {
            
            emailErrorLabel.text = ""
            
            return true
        }
        
    }
    
    func validatePass() -> Bool {
        
        let passText = passField.text!
        
        if passText.isEmpty {
            
            passErrorLabel.text = "Zapolnite eto pole"
            
            return false
        } else if passText.count < 6{
            
            passErrorLabel.text = "Parol' dojlen byt bolee 6 sym"
            return false
            
        } else {
            
            passErrorLabel.text = ""
            return true
        }
    }
    
    
    func validateConfPass() -> Bool {
        
        
        let passConfText = passConfField.text!
        
        if passConfField.text!.isEmpty {
            
            passConfError.text = "Zapolnite eto pole"
            
            return false
            
        } else if !passField.text!.elementsEqual(passConfText){
            
            passConfError.text = "PASS mismatch"
            
            return false
            
        } else {
            passConfError.text = ""
            
            return true
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


extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
}


// MARK: - SuccessRegister
struct SuccessRegister: Codable {
    var success, name, tokenType, token: String

    enum CodingKeys: String, CodingKey {
        case success, name
        case tokenType = "token_type"
        case token
    }
}
