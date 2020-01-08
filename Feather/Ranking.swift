//
//  Ranking.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 10/31/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit

class Ranking: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array = ["acne", "anti-aging/wrinkles", "dryness/hydration", "oil control/pores", "pigmentation", "redness", "sensitive"]
    
    @IBOutlet weak var RankingTable: UITableView!
    @IBOutlet weak var EditButton: UIButton!
    
    @IBAction func Edit(_ sender: Any)
    {
        RankingTable.isEditing = !RankingTable.isEditing
        
        switch RankingTable.isEditing {
        case true:
            EditButton.setTitle("done", for: .normal)
        case false:
            EditButton.setTitle("edit", for: .normal)
        }
    }
    
    // setting up the cell with the array of data we have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = array[indexPath.row]
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
        let item = array[sourceIndexPath.row]
        array.remove(at: sourceIndexPath.row)
        array.insert(item, at: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
