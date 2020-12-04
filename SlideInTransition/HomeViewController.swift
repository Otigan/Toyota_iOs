import UIKit
import SDWebImage


class HomeViewController: UIViewController, didSelectAutoDelegate, DetailedNewsProtocol, onSelectService{
    
    var checkLoginRepair = false
    
    var checkContactsChildView = false
    
    var fromRegisterToServices = false
    
    var fromLoginToServices = false
    
    var checkChatChildView = false
    
    var checkShopChildView = false
    
    var contactsVC: ContactsViewController?

    var chatVC: ChatViewController!
    

    var shopVC: ShopViewController!
    
    func selectedService(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("check")
        
        if servicesListTable != nil {
            let nameOfService = servicesListTable?.servicesList[indexPath.row]
            
        
            
            if nameOfService!.elementsEqual("Ремонт") {
                clickRepair()
            }
        }
    }
    

    
    func showDetailNews(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let detailedNewsVC = storyboard?.instantiateViewController(withIdentifier: "DetailedNewsViewController") as! DetailedNewsViewController
        
    
        detailedNewsVC.detailNews = newsTable?.newsList[indexPath.row]
    
        navigationController?.pushViewController(detailedNewsVC, animated: true)
    
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("HEH")
    }
    
    
    let transiton = SlideInTransition()
    var topView: UIView?
    
    let loginVC = LoginController()
    
    var usersAutoTable: UsersAutoTable?
    
    var newsTable: NewsTableViewController?
    
    var servicesListTable: ServicesListTable?
    
    var menuViewController: MenuViewController?
    
    var checkNewsChildView = false
    
    var checkUserAutosChildView = false
    
    var checkServicesListChildView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        transitionToNew(.новости)
        
        let panGesture = UIPanGestureRecognizer(target: menuViewController!, action: #selector(panMenu(sender:)))
        
        view.addGestureRecognizer(panGesture)
        
    }
    
    @objc func panMenu(sender: UIPanGestureRecognizer) {
        
        if sender.state == .began || sender.state == .changed {
            
            let translation = sender.translation(in: self.view).x
            
            if translation > 0 {
                menuViewController!.modalPresentationStyle = .overCurrentContext
                menuViewController!.transitioningDelegate = self
                present(menuViewController!, animated: true)
                
            } else {
                
            }
            
        } else if sender.state == .ended {
            
        }
        
    }
    
    func clickRepair()->Void {
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        
        
        loginVC.modalPresentationStyle = .fullScreen
        
        
        if UserDefaults.standard.string(forKey: "token") == nil {
            //present(loginVC, animated: true)
            
            loginVC.noAuthRepair = true
            
            navigationController?.pushViewController(loginVC, animated: true)
            
            
        } else {
            print("LOGGED")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let repairVC = storyboard.instantiateViewController(withIdentifier: "RepairViewController") as! RepairViewController
            
            
            self.navigationController?.pushViewController(repairVC, animated: true)
            
            
        }
    }
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        
        menuViewController!.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        
        menuViewController!.modalPresentationStyle = .overCurrentContext
        menuViewController!.transitioningDelegate = self
        present(menuViewController!, animated: true)
    }
    
    func transitionToNew(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title
        
        topView?.removeFromSuperview()
        switch menuType {
            
        case .новости:
            removeChildVC()
            removeServicesListChildView()
            removeContactsChildView()
            removeChatChildView()
            removeShopChildView()
            
            addNewsChildView()
            
            
        case .login:
            
            removeChildVC()
            removeNewsChildVC()
            removeServicesListChildView()
            removeContactsChildView()
            removeChatChildView()
            removeShopChildView()
            
            
            
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
            addServicesListChildView()
            removeContactsChildView()
            removeChatChildView()
            removeShopChildView()
            
            
            
            
        case .чат:
            removeChildVC()
            removeNewsChildVC()
            removeServicesListChildView()
            removeContactsChildView()
            addChatChildView()
            removeShopChildView()
            
            
        case .магазин:
            removeChildVC()
            removeNewsChildVC()
            removeServicesListChildView()
            removeContactsChildView()
            removeChatChildView()
            addShopView()
            
            
            
        case .контакты:
            removeChatChildView()
            removeChildVC()
            removeNewsChildVC()
            removeServicesListChildView()
            addContactsChildView()
            removeShopChildView()
            
            
        case .автомобили:
            
            //let view = UIView()
            
            //view.frame = self.view.bounds
            //self.view.addSubview(view)
            //self.topView = view
            removeNewsChildVC()
            removeServicesListChildView()
            removeChatChildView()
            removeContactsChildView()
            removeShopChildView()
            
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
            removeChatChildView()
            removeChildVC()
            removeNewsChildVC()
            removeServicesListChildView()
            removeShopChildView()
            removeContactsChildView()
            
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
    
    override func viewDidAppear(_ animated: Bool) {
        
        if fromRegisterToServices || fromLoginToServices{
            
            fromRegisterToServices = false
            
            fromLoginToServices = false
            
            clickRepair()
            
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
    
    func addChatChildView() {
        
        if checkChatChildView == false {
            
            chatVC =  ChatViewController()
            
            self.view.addSubview(chatVC.view)
            
            self.addChild(chatVC)
            
            chatVC.didMove(toParent: self)
            
            checkChatChildView = true
        }
    }
    
    func removeChatChildView() {
        
        if checkChatChildView == true {
            
            chatVC.willMove(toParent: nil)
            chatVC.view.removeFromSuperview()
            chatVC.removeFromParent()
            
            chatVC = nil
            
            checkChatChildView = false
            
        }
    }
    
    
    func addShopView() {
        
        if !checkShopChildView {
            
            shopVC = ShopViewController()
            
            self.view.addSubview(shopVC.view)
            
            self.addChild(shopVC)
            
            shopVC.didMove(toParent: self)
            
            
            checkShopChildView = true
            
        }
        
    }
    
    func removeShopChildView() {
        
        if checkShopChildView {
            
            shopVC.willMove(toParent: nil)
            shopVC.view.removeFromSuperview()
            shopVC.removeFromParent()
            
            checkShopChildView = false
        }
    }
    
    func addContactsChildView() {
        
        if checkContactsChildView == false {
            
        
            contactsVC = self.storyboard!.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
            
            
            self.view.addSubview(contactsVC!.view)
            self.addChild(contactsVC!)
            contactsVC!.didMove(toParent: self)
            checkContactsChildView = true
        }
        
    }
    
    func removeContactsChildView() {
        
        if checkContactsChildView == true {
            contactsVC!.willMove(toParent: nil)
            contactsVC!.view.removeFromSuperview()
            contactsVC?.removeFromParent()
            
            contactsVC = nil
            
            checkContactsChildView = false
        }
    }
    
    func addServicesListChildView() {
        
        if checkServicesListChildView == false {
            
            servicesListTable = ServicesListTable()
 
            servicesListTable?.delegate = self
            
            self.view.addSubview(servicesListTable!.view)
                   
            self.addChild(servicesListTable!)
                   
            servicesListTable!.didMove(toParent: self)
            
            checkServicesListChildView = true
            
            
            
        }
        
    }
    
    func removeServicesListChildView() -> Void {
        
        if checkServicesListChildView == true {
            
            servicesListTable?.willMove(toParent: nil)
            servicesListTable?.view.removeFromSuperview()
            servicesListTable?.removeFromParent()
            
            servicesListTable = nil
            
            checkServicesListChildView = false
            
            
        }
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
