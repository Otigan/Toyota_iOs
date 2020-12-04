//
//  AllAutosShop.swift
//  SlideInTransition
//
//  Created by otigan on 10.11.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AllAutosShop: UIViewController {
    
    var shopAutos = [ShopAuto]()
    
    var mode: String

    convenience init() {
        self.init(mode: "")
    }
    
    init(mode: String) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //layout.estimatedItemSize = CGSize(width: 50.0, height: 50.0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ShopAutoCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        
       
        
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getJSON {
            self.collectionView.reloadData()
            print("DATAAA \(self.shopAutos.count)")
        }
        
        
    }
    
    
    func update(mode: String) {
        
        self.mode = mode
        
        getJSON {
            self.collectionView.reloadData()
            print("DATAAA \(self.shopAutos.count)")
        }
        
    }
    
    private func getJSON(completed: @escaping () -> ()) {
            
                let urll = URL(string: "http://toyota-rest.ru/api/get_shop_autos")!
                        
                var request = URLRequest(url: urll)
                
                request.httpMethod = "GET"
                
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
                guard let token = UserDefaults.standard.string(forKey: "token") else { return }
                
                request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
                
                //guard let httpBody = try? JSONSerialization.data(withJSONObject: GL_NONE, options: []) else {return}
                
                //request.httpBody = httpBody
                
                let session = URLSession.shared
                session.dataTask(with: request) {(data, response, error) in
                    
                    if let response = response {
                        print(response)
                    
                    }
                    
                    guard let data = data else { return }
                    do {
                        self.shopAutos = try JSONDecoder().decode([ShopAuto].self, from: data)
                
            
                        DispatchQueue.main.async {
                            completed()
                        }
                    
                        
                    } catch {
                        print(error)
                    }
            }.resume()
    
    }
    
    

}


// MARK: ShopAuto
struct ShopAuto: Codable {
    var id: Int
    var createdAt, updatedAt, name: String
    var price, yearOfIssue: Int
    var image, quality: String
    var mileage: Int
    var transmission, engineType, bodyType, power: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case name, price
        case yearOfIssue = "year_of_issue"
        case image, quality, mileage, transmission
        case engineType = "engine_type"
        case bodyType = "body_type"
        case power
    }
}


extension AllAutosShop: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 100, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if mode.elementsEqual("new autos") {
          
            
            shopAutos.removeAll(where: {$0.quality.elementsEqual("used")})
            
            
        } else if mode.elementsEqual("old autos") {
            
            shopAutos.removeAll(where: {$0.quality.elementsEqual("new")})
        
            
        
        }
        
        return shopAutos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShopAutoCell
        
        
        let url = URL(string: "http://toyota-rest.ru/storage/" + shopAutos[indexPath.row].image)!
        
       
                
        cell.image.sd_setImage(with: url, placeholderImage: UIImage(contentsOfFile: "thumb-jpg.png"))
        
        if mode.elementsEqual("new autos"){
            cell.autoName.text = "lol"
        }
            
        cell.autoName.text = "kek" //shopAutos[indexPath.row].name
    
        print(" NAME \(shopAutos[indexPath.row].name)")
        

        cell.layoutIfNeeded()
        
        return cell
    }
    
    
    
}


class ShopAutoCell: UICollectionViewCell {
    
    
    
    let image = UIImageView()
    let autoName = UILabel()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        
        
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 7.0
        
        image.translatesAutoresizingMaskIntoConstraints = false
        autoName.translatesAutoresizingMaskIntoConstraints = false
        
    
        //image.clipsToBounds = true
        image.layer.cornerRadius = 10.0
        
        image.contentMode = .scaleAspectFit
        contentView.addSubview(image)
        contentView.addSubview(autoName)
        
         
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        image.bottomAnchor.constraint(equalTo: autoName.topAnchor).isActive = true
        
        autoName.topAnchor.constraint(equalTo: image.bottomAnchor).isActive = true
        
        autoName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        autoName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        autoName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
