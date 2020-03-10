//
//  Recommendation.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 3/9/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import UIKit

class Recommendation: UIViewController {

    
    @IBOutlet weak var recommendationTableView: UITableView!
    
    let collection = ViewController.SignUpUser.currentCollection
    let doc = ViewController.SignUpUser.userAuthUID
    var recs = [ProductInfo]()
    var recsString = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadRecommendationData()
    }
    
    func downloadRecommendationData()
    {
        let alert = UIAlertController(title: "Please standby", message: "Currently loading lots of cool data...", preferredStyle: .alert)
         DispatchQueue.main.async
                {
                    self.present(alert, animated: true, completion: nil)
                }
        // ========================
        // NEED TO CALL PYTHON HERE
        // ========================
        
        let url = URL(string: "JSON FROM JACKY")
        
        URLSession.shared.dataTask(with: url!)
        {
            (data, response, error) in
                do
                {
                    print("before parsing json")
                    ViewController.SignUpUser.recommendations = try JSONDecoder().decode([ProductInfo].self, from: data!)
                    
                    for prod in ViewController.SignUpUser.recommendations
                    {
                        self.recsString.append(prod.name)
                    }
                    print("GOT ALL RECOMMENDATION")
                        
                    DispatchQueue.main.async
                    {
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
                catch
                {
                    print("My JSON Decoding Error")
                }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return recs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recommendationCell")
        cell?.textLabel?.text = recsString[indexPath.row]
        cell?.textLabel?.font = UIFont(name: "Palatino", size: 20.0)
        cell?.textLabel?.textColor = UIColor.white
        return cell!
    }
    
    //doesn't allow deletion TODO (doesn't work)
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int
    {
        return 0
    }
    
    // functions for moving the cell rows around
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let item = recsString[sourceIndexPath.row]
        recsString.remove(at: sourceIndexPath.row)
        recsString.insert(item, at: destinationIndexPath.row)
    }
    

}
