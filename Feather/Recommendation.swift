//
//  Recommendation.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 3/9/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import UIKit
import FirebaseFirestore

class Recommendation: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var recsString = [String]()
    @IBOutlet weak var recTableView: UITableView!
    
    let collection = ViewController.SignUpUser.currentCollection
    let doc = ViewController.SignUpUser.userAuthUID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadRecommendationData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recsString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recTableView.dequeueReusableCell(withIdentifier: "recommendationCell")
        cell?.textLabel?.text = self.recsString[indexPath.row]
        return cell!
    }
    
    func downloadRecommendationData()
    {
        // ========================
        // NEED TO CALL PYTHON HERE
        // ========================
        
        let url = URL(string:"https://raw.githubusercontent.com/mmachiya/feather/master/WebScraping/fakerecommendation.json")
        
        URLSession.shared.dataTask(with: url!)
        {
            (data, response, error) in
                do
                {
                    print("before parsing json")
                    ViewController.SignUpUser.recommendations = try JSONDecoder().decode([ProductInfo].self, from: data!)
                    print("after parsing json")
                    
                    for prod in ViewController.SignUpUser.recommendations
                    {
                        let tempname: String = prod.brand + " " + prod.name
                        self.recsString.append(tempname)
                    }
                    print(self.recsString)
                    print("GOT ALL RECOMMENDATION")
                }
                catch let error
                {
                    print(error)
                    print("My JSON Decoding Error")
                }
            DispatchQueue.main.async
            {
                self.recTableView.reloadData()
            }
            
        }.resume()
    }
}
