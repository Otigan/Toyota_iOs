//
//  NewsTableViewController.swift
//  SlideInTransition
//
//  Created by otigan on 06.10.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit


protocol DetailedNewsProtocol: class {
    func showDetailNews(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

class NewsTableViewController: UITableViewController {
    
    
    var newsList = [NewsElement]()
    
    weak var delegate: DetailedNewsProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        UserDefaults.standard.value(forKey: "token")
        
    
        
        tableView.tableFooterView = UIView()
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        
          
             
             
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
        return newsList.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
    
        
        
        cell.newsImage.frame.size = CGSize(width: tableView.frame.width, height: 150)
        
        
        cell.newsImage.contentMode = .scaleAspectFill
        
         let url = URL(string: "http://toyotarest.ru/storage/" + newsList[indexPath.row].image)!

               cell.newsImage.sd_setImage(with: url, placeholderImage: UIImage(contentsOfFile: "thumb-jpg.png"))
        
        
        let imageRatio = CGFloat(cell.newsImage.frame.width / cell.newsImage.frame.height)

        
        tableView.rowHeight = (tableView.frame.width / imageRatio) + 80
        
        
        cell.newsTitle.text = newsList[indexPath.row].title
        

    
    
        
        let formatter = DateFormatter()
        
        //let templocale = formatter.locale
        
        //formatter.locale = Locale(identifier: "en_US_POSIX")
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        formatter.timeZone = TimeZone(secondsFromGMT: 3600 * 7)
        
        let date = formatter.date(from: newsList[indexPath.row].createdAt)!
    
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        //formatter.locale = templocale
        
        let dateStr = formatter.string(from: date)
        
        
        cell.newsDate.text = dateStr
        
        cell.newsTitle.translatesAutoresizingMaskIntoConstraints = false
        
        cell.newsTitle.topAnchor.constraint(equalTo: cell.newsImage.bottomAnchor).isActive = true
       
        cell.newsDate.translatesAutoresizingMaskIntoConstraints = false
        
        cell.newsDate.topAnchor.constraint(equalTo: cell.newsTitle.bottomAnchor).isActive = true
        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.showDetailNews(tableView, didSelectRowAt: indexPath)
    }
    
    private func getJSON(completed: @escaping () -> ()) {
    
        let urll = URL(string: "http://toyotarest.ru/api/get_news")!
                
        var request = URLRequest(url: urll)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        let session = URLSession.shared
        session.dataTask(with: request) {(data, response, error) in
            
            if let response = response {
                print(response)
            
            }
            
            guard let data = data else { return }
            do {
                self.newsList = try JSONDecoder().decode([NewsElement].self, from: data)
        
    
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
}

// MARK: - NewsElement
struct NewsElement: Codable {
    var id: Int
    var title, subtitle, text, image: String
    var createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, text, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        }
}
