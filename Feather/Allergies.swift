//
//  AllergiesProducts.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 12/4/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit

class Allergies: UIViewController {
    
    let ingredients = ["Alcohol", "Alpha-hydroxy acids", "Alpha-lipoic acid", "Benzopropyl", "Beta-hydroxy acid", "Copper peptide", "DMAE (dimethylaminoethanol)", "Hyaluronic acid", "Hydroquinone", "Kojic acid", "L-ascorbic acid", "Polyhydroxy acids", "Retinoids", "Salic Acid"]

    var searchedAllergy = [String]()
    var searching = false

    @IBOutlet weak var allergiesSearchBar: UISearchBar!
    @IBOutlet weak var allergiesTableView: UITableView!
    @IBOutlet weak var textOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ingredient = ingredients[indexPath.row]
        textOutput.text += "- "
        textOutput.text += ingredient
        textOutput.text += "\n"
        allergiesTableView.reloadData()
    }

}

extension Allergies: UITableViewDelegate, UITableViewDataSource {
    
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
            cell?.textLabel?.text = ingredients[indexPath.row]
        }
        return cell!
    }
    
    
}

extension Allergies: UISearchBarDelegate {
    
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
