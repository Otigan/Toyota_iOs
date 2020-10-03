import UIKit
import SDWebImage


class HomeViewController: UIViewController, didSelectAutoDelegate{
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("HEH")
    }
    

    let transiton = SlideInTransition()
    var topView: UIView?
    
    let loginVC = LoginController()
    
    var usersAutoTable: UsersAutoTable?



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
          
          let view = UIView()
                    //view.backgroundColor = .blue
                    view.frame = self.view.bounds
                    self.view.addSubview(view)
                    self.topView = view
                    
                    let text = UILabel(frame: CGRect(x:100, y:100, width:100, height:50))
                    text.text = "News"
                    view.addSubview(text)
            
        case .login:
            
            removeChildVC()
            
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
            
            if UserDefaults.standard.string(forKey: "token") == nil {
                
                let text = UILabel(frame: CGRect(x:100, y:100, width: 100, height: 50))
                
                text.text = "No autos"
                view.addSubview(text)
                
                print("NOT LOGGED IN")
            } else {
                
                usersAutoTable = UsersAutoTable()
                
                usersAutoTable?.delegate = self
                
                self.view.addSubview(usersAutoTable!.view)
                
                self.addChild(usersAutoTable!)
                
                usersAutoTable!.didMove(toParent: self)
                
            }
            
        default:
            break
        }
    }
    
    
    func removeChildVC() -> Void {
        if usersAutoTable != nil {
            usersAutoTable!.willMove(toParent: nil)
            usersAutoTable!.view.removeFromSuperview()
            usersAutoTable!.removeFromParent()
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
