//
//  MastersTableViewController.swift
//  SlideInTransition
//
//  Created by otigan on 27.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit

class MastersTableViewController: UITableViewController {
    
    weak var delegate: didTapDelegate?
    
    var masters = [MastersListElement]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(MastersListCell.self, forCellReuseIdentifier: "cell")
        
        tableView.bounces = true
        
        
        tableView.tableFooterView = UIView()
        
        getJSON() {
            self.tableView.reloadData()
        }
        
        print(self.masters.count)
        
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
        return masters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MastersListCell
        
        
        cell.cellLabel.text = masters[indexPath.row].name
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.masterSelect(tableView, didSelectRowAt: indexPath)
        
        
    }
  
    
    private func getJSON(completed: @escaping () -> ()) {
    
        let urll = URL(string: "http://toyotarest.ru/api/masters")!
                
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
                self.masters = try JSONDecoder().decode([MastersListElement].self, from: data)
        
    
                DispatchQueue.main.async {
                    completed()
                }
            
                
            } catch {
                print(error)
            }
    }.resume()
    

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
    
    // MARK: - MastersListElement
    struct MastersListElement: Codable {
        let id: Int
        let name, createdAt, updatedAt: String
        let repairID: JSONNull?

        enum CodingKeys: String, CodingKey {
            case id, name
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case repairID = "repair_id"
        }
    }


    // MARK: - Encode/decode helpers

    class JSONNull: Codable, Hashable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }

        public var hashValue: Int {
            return 0
        }

        public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
}


protocol didTapDelegate: class {
    func masterSelect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
      }
