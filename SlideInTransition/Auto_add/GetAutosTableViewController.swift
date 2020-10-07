//
//  GetAutosTableViewController.swift
//  SlideInTransition
//
//  Created by otigan on 05.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit


protocol ModelSelect: class {
    func didSelectAutoModel(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    }



class GetAutosTableViewController: UITableViewController {

    
    
    var autoModels = [AutoModelElement]()
    
    weak var delegate : ModelSelect?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "Models"
        
        tableView.register(GetAutosTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = 150
            
            tableView.tableFooterView = UIView()
            
            getJSON() {
                self.tableView.reloadData()
            }
            
        
            tableView.delegate = self
            tableView.dataSource = self
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return autoModels.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.didSelectAutoModel(tableView, didSelectRowAt: indexPath)
        
    }
    
    
    
    private func getJSON(completed: @escaping () -> ()) {
            
                let urll = URL(string: "http://toyotarest.ru/api/get_models")!
                        
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
                        self.autoModels = try JSONDecoder().decode([AutoModelElement].self, from: data)
                
            
                        DispatchQueue.main.async {
                            completed()
                        }
                    
                        
                    } catch {
                        print(error)
                    }
            }.resume()
    
    }
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GetAutosTableViewCell
               
               let url = URL(string: "http://toyotarest.ru/storage/" + autoModels[indexPath.row].modelImage)!
               
               cell.modelAutoImage.sd_setImage(with: url, placeholderImage: UIImage(contentsOfFile: "thumb-jpg.png"))
        
        cell.modelAutoName.text = autoModels[indexPath.row].name
    
               
               
               return cell
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - AutoModelElement
struct AutoModelElement: Codable {
    let id: Int
    let name, modelImage, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case modelImage = "model_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
