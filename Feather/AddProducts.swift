//
//  AddProducts.swift
//  Feather
//
//  Created by Kristina Tran on 3/9/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddProducts: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    let collection = ViewController.SignUpUser.currentCollection
    let doc = ViewController.SignUpUser.userAuthUID

    var searchedProducts = [String]()
    var searching = false
    
    // has brand then name
    var userUsedProducts = [String]()

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
        
        if !userUsedProducts.contains(prod)
        {
            userUsedProducts.append(prod)
            let tempProd: ProductInfo
            let tempList: [ProductInfo]
            tempProd = ViewController.Database.products[indexPath.row]
            tempList = ViewController.SignUpUser.myProducts[tempProd.category] ?? []
            
            ViewController.SignUpUser.myProducts[tempProd.category] = tempList + [tempProd]
            
            textOutput.text += "+ "
            textOutput.text += prod
            textOutput.text += "\n"
        }
        ViewController.SignUpUser.db.collection(collection).document(doc).setData(["myProducts": FieldValue.arrayUnion(userUsedProducts)], merge: true)
        
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
