//
//  BadProducts.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 12/4/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit
import FirebaseFirestore

class BadProducts: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    let collection = ViewController.SignUpUser.currentCollection
    let doc = ViewController.SignUpUser.userAuthUID

    var searchedProducts = [String]()
    var searching = false
    
    // has brand then name
    var userBadProducts = [String]()

    @IBOutlet weak var productSearchBar: UISearchBar!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var textOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prod: String
        
        if searching {
            prod = searchedProducts[indexPath.row]
        }
        else
        {
            prod = ViewController.Database.productsString[indexPath.row]
        }
        
        if !userBadProducts.contains(prod)
        {
            userBadProducts.append(prod)
            ViewController.SignUpUser.badProducts.append(prod)
            textOutput.text += "- "
            textOutput.text += prod
            textOutput.text += "\n"
        }
        ViewController.SignUpUser.db.collection(collection).document(doc).setData(["badProducts": FieldValue.arrayUnion(userBadProducts)], merge: true)
        
        productTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedProducts.count
        } else {
            return ViewController.Database.productsString.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell")
        if searching {
            cell?.textLabel?.text = searchedProducts[indexPath.row]
        } else {
            cell?.textLabel?.text = ViewController.Database.productsString[indexPath.row]
        }
        return cell!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedProducts = ViewController.Database.productsString.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        productTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        productTableView.reloadData()
    }
}
