//
//  BadProducts.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 12/4/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit

class BadProducts: UIViewController {

    let products = ["Biore Morning Clenser", "CeraVe Renewing Gel Oil Face Moisturizer", "Clinique Repairwear Anti-Gravity Eye Cream", "Cetaphil Daily Facial Clenser", "Dear Klair's Heavy Moisturizer", "Neutrogena Rapid Wrinkle Repair Eye Cream"]

    var searchedProducts = [String]()
    var searching = false

    @IBOutlet weak var productSearchBar: UISearchBar!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var textOutput: UITextView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ingredient = products[indexPath.row]
        textOutput.text += "- "
        textOutput.text += ingredient
        textOutput.text += "\n"
        productTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BadProducts: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedProducts.count
        } else {
            return products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell")
        if searching {
            cell?.textLabel?.text = searchedProducts[indexPath.row]
        } else {
            cell?.textLabel?.text = products[indexPath.row]
        }
        return cell!
    }
}

extension BadProducts: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedProducts = products.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        productTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        productTableView.reloadData()
    }
}

