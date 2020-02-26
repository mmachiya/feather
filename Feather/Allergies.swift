//
//  AllergiesProducts.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 12/4/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit
import FirebaseFirestore

class Allergies: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    let collection = ViewController.SignUpUser.currentCollection
    let doc = ViewController.SignUpUser.userAuthToken
    
    var searchedAllergy = [String]()
    var searching = false
    
    var products = [ProductInfo]()
    var ingredients = [String]()
    var allergies = [String]()
        
    @IBOutlet weak var allergiesSearchBar: UISearchBar!
    @IBOutlet weak var allergiesTableView: UITableView!
    @IBOutlet weak var textOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadIngredientsData()
    }
    
    func downloadIngredientsData()
    {
        let url = URL(string: "https://raw.githubusercontent.com/mmachiya/feather/master/WebScraping/newulta2.json")
        URLSession.shared.dataTask(with: url!)
        {
            (data, response, error) in
                do
                {
                    print("before parsing json")
                    self.products = try JSONDecoder().decode([ProductInfo].self, from: data!)
                    print("past json decoder")
                    for prod in self.products
                    {
                        for i in prod.self.ingredients
                       {
                        if !self.ingredients.contains(i)
                           {
                            self.ingredients.append(i)
                           }
                       }
                    }
                    self.ingredients.sort()
                    DispatchQueue.main.async
                    {
                        self.allergiesTableView.reloadData()
                    }
                }
                catch
                {
                    print("My JSON Decoding Error")
                }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ingredient: String
        
        if searching {
            ingredient = searchedAllergy[indexPath.row]
        }
        else
        {
            ingredient = ingredients[indexPath.row]
        }
        
        if !allergies.contains(ingredient)
        {
            allergies.append(ingredient)
            ViewController.SignUpUser.allergies.append(ingredient)
            textOutput.text += "- "
            textOutput.text += ingredient
            textOutput.text += "\n"
        }
        
        let ref = ViewController.SignUpUser.db.collection(collection).document(doc)
                
        ref.setData(["allergies": FieldValue.arrayUnion(allergies)], merge: true)
        
        allergiesTableView.reloadData()
    }
    
    // how many rows there is, depending on the data available
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedAllergy.count
        } else {
            return ingredients.count
        }
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allergyCell")
        if searching {
            cell?.textLabel?.text = searchedAllergy[indexPath.row]
        } else {
            cell?.textLabel?.text = ingredients[indexPath.row]
        }
        return cell!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedAllergy = ingredients.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        allergiesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        allergiesTableView.reloadData()
    }
}
