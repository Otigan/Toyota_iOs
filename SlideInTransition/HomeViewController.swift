import UIKit
import SDWebImage


class HomeViewController: UIViewController, didSelectAutoDelegate, DetailedNewsProtocol{
    
    
    
    func showDetailNews(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("detail news")
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("HEH")
    }
    

    let transiton = SlideInTransition()
    var topView: UIView?
    
    let loginVC = LoginController()
    
    var usersAutoTable: UsersAutoTable?

    var newsTable: NewsTableViewController?
    
    var checkNewsChildView = false
    
    var checkUserAutosChildView = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        transitionToNew(.новости)
                
        
    
    }
        
            
    
    @objc func clickRepair(sender: UIButton!) {
                   
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                               
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
                             
                              
            loginVC.modalPresentationStyle = .fullScreen
                              
                             
                   if UserDefaults.standard.string(forKey: "token") == nil {
                       present(loginVC, animated: true)
                   } else {
                       print("LOGGED")
                    
                         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                     
                                   let repairVC = storyboard.instantiateViewController(withIdentifier: "RepairViewController") as! RepairViewController
                    
                                
                    self.navigationController?.pushViewController(repairVC, animated: true)
                                    
                                    //repairVC.modalPresentationStyle = .fullScreen
                    
                        //let nav = UINavigationController(rootViewController: repairVC)
                    
                    //nav.modalPresentationStyle = .fullScreen
                                    
                                   //present(nav, animated: true)
                    
        }
               }
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }

    func transitionToNew(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title

        topView?.removeFromSuperview()
        switch menuType {
            
        case .новости:
          removeChildVC()
       
         
            addNewsChildView()
          
            
        case .login:
            
            removeChildVC()
            removeNewsChildVC()
            
            
           
            transitionToNew(.новости)
            
        
            
           // let view = UIView()
                  //    view.backgroundColor = .blue
                   //   view.frame = self.view.bounds
                   //   self.view.addSubview(view)
                   //   self.topView =
            //check = true
            //viewDidLoad()
            
            
            
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
                              
                   let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
            
             
             self.navigationController?.pushViewController(loginVC, animated: true)
            
             //loginVC.modalPresentationStyle = .fullScreen
             
            //present(loginVC, animated: true)
            
            
            
        case .услуги:
            removeChildVC()
            removeNewsChildVC()
            
            
                        
            let view = UIView()
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
            let buttonRepair = UIButton(frame: CGRect(x:100, y:100, width:100, height:50))
            
            buttonRepair.setTitle("Ремонт", for: .normal)
            buttonRepair.setTitleColor(.white, for: .normal)
            if #available(iOS 13.0, *) {
                buttonRepair.backgroundColor = .systemGray3
            } else {
                buttonRepair.backgroundColor = .gray
            }
            
            buttonRepair.addTarget(self, action: #selector(clickRepair), for: UIControl.Event.touchUpInside)
            view.addSubview(buttonRepair)
            
            
        
            
           
            
        case .контакты:
       
            removeChildVC()
            removeNewsChildVC()
            
            let view = UIView()
            //view.backgroundColor = .blue
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
            
            let text = UILabel(frame: CGRect(x:100, y:100, width:100, height:50))
            text.text = "Contacts"
            view.addSubview(text)
            
            
        case .автомобили:
            
            //let view = UIView()
            
            //view.frame = self.view.bounds
            //self.view.addSubview(view)
            //self.topView = view
            removeNewsChildVC()
            
            if UserDefaults.standard.string(forKey: "token") == nil {
                
                
                let view = UIView()
                
                view.frame = self.view.bounds
                self.view.addSubview(view)
                self.topView = view
                
                let text = UILabel(frame: CGRect(x:100, y:100, width: 100, height: 50))
                
                text.text = "No autos"
                view.addSubview(text)
                
                print("NOT LOGGED IN")
            } else {
                
                addUsersAutoChildView()
               
                
            }
            
        case .профиль:
            
            removeChildVC()
            removeNewsChildVC()
            
            let view = UIView()
            
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
            
            let label = UILabel(frame: CGRect(x: 100, y:100, width: 100, height: 150))
            label.text = "PROFILE"
            view.addSubview(label)
            
            let button = UIButton(frame: CGRect(x:150, y:150, width: 200, height: 200))
            button.backgroundColor = .gray
            button.titleLabel?.text = "Log out"
            button.addTarget(self, action: #selector(logOut), for: .touchDown)
            view.addSubview(button)
            
            
        default:
            break
        }
    }
    
    @objc func logOut() {
        
        
        UserDefaults.standard.removeObject(forKey: "token")
        transitionToNew(.новости)
    }
    
    @objc func addAuto() {
        
        
        let addAutoController = storyboard?.instantiateViewController(withIdentifier: "AddAutoController") as! AddAutoController
        
        self.navigationController?.pushViewController(addAutoController, animated: true)
        
    }
    
    
    func addNewsChildView() {
        
            if checkNewsChildView == false {
                
                    newsTable = NewsTableViewController()
                                             
                                          newsTable?.delegate = self
                                             
                                             self.view.addSubview(newsTable!.view)
                                             
                                             self.addChild(newsTable!)
                                             
                                             newsTable!.didMove(toParent: self)
                
                checkNewsChildView = true
                
    
        }
        
      
        
        
        
        
    }
    
    
    
    func addUsersAutoChildView() {
        
        
        if checkUserAutosChildView == false {
            
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAuto))
             
            
             usersAutoTable = UsersAutoTable()
             
             usersAutoTable?.delegate = self
             
             self.view.addSubview(usersAutoTable!.view)
             
             self.addChild(usersAutoTable!)
             
             usersAutoTable!.didMove(toParent: self)
            
            
            checkUserAutosChildView = true
            
        }
        
        
        
    }
    
    func removeChildVC() -> Void {
        
   
        
        
        if checkUserAutosChildView == true {
            usersAutoTable!.willMove(toParent: nil)
            usersAutoTable!.view.removeFromSuperview()
            usersAutoTable!.removeFromParent()
            
            
            usersAutoTable = nil
            navigationItem.rightBarButtonItem = nil
            
            checkUserAutosChildView = false
            
        }
        
    }
    
    func removeNewsChildVC() -> Void {
     
        
        if checkNewsChildView != nil {
            if checkNewsChildView == true {
               
               newsTable!.willMove(toParent: nil)
                              newsTable!.view.removeFromSuperview()
                              newsTable!.removeFromParent()
                              newsTable = nil
                
                checkNewsChildView = false
                
            }
        }
        
        
    }

}
    


extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
