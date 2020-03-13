//
//  AllergiesProducts.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 12/4/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit
import FirebaseFirestore

protocol AllergiesProtocol {
    func didSelectCell(data:String)
}

class Allergies: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    let collection = ViewController.SignUpUser.currentCollection
    let doc = ViewController.SignUpUser.userAuthUID
    
    var allergyProtocol : AllergiesProtocol?
    
    var searchedAllergy = [String]()
    var searching = false
    
    var ingredients = ViewController.Database.ingredients
    
    var allergies = [String]()
        
    @IBOutlet weak var allergiesSearchBar: UISearchBar!
    @IBOutlet weak var allergiesTableView: UITableView!
    @IBOutlet weak var textOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        allergyProtocol?.didSelectCell(data:ingredient)
        
        //let ref = ViewController.SignUpUser.db.collection(ViewController.SignUpUser.currentCollection).document(ViewController.SignUpUser.userAuthUID)
                
        //ref.setData(["allergies": FieldValue.arrayUnion(allergies)], merge: true)
        
        //allergiesTableView.reloadData()
    }
    
    // how many rows there is, depending on the data available
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedAllergy.count
        } else {
            return ingredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allergyCell")
        if searching {
            cell?.textLabel?.text = searchedAllergy[indexPath.row]
        } else {
            cell?.textLabel?.text = ViewController.Database.ingredients[indexPath.row]
        }
        return cell!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedAllergy = ViewController.Database.ingredients.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        allergiesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        allergiesTableView.reloadData()
    }
}
