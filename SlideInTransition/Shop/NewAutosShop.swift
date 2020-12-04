//
//  NewAutosShop.swift
//  SlideInTransition
//
//  Created by otigan on 24.11.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit


class NewAutosShop: UIViewController {
    
    
    var shopAutos = [ShopAuto]()
    
    var mode: String!
    
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        getJSON {
            self.collectionView.reloadData()
            print("DATAAA \(self.shopAutos.count)")
        }
        
    }
    
    
    func update() {
        self.collectionView.reloadData()
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
                
                self.shopAutos.removeAll(where: {$0.quality.elementsEqual("used")})
                
                DispatchQueue.main.async {
                    completed()
                }
                
                
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
    
    
}


extension NewAutosShop: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 100, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
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

    
