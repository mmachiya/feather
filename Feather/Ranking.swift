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
    
    let collection = ViewController.SignUpUser.currentCollection
    let doc = ViewController.SignUpUser.userAuthUID
    
    @IBOutlet weak var RankingTable: UITableView!
    
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
        RankingTable.isEditing = true
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        transitionBack()
    }
    
    func transitionBack()
    {
        let profile = storyboard?.instantiateViewController(identifier: "SkinProfileVC") as? SkinProfile
                
        view.window?.rootViewController = profile
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        transitionNext()
    }
    
    func transitionNext()
    {
       let allergies = storyboard?.instantiateViewController(identifier: "AllergiesVC") as? Allergies
        
       let dataReference = ViewController.SignUpUser.db.collection(collection).document(doc)

        for i in array.indices
        {
            print(i+1)
            print(array[i])
             ViewController.SignUpUser.concernsRanking[String(i+1)] = array[i]
            dataReference.setData(["concernsRanking":[String(i+1):(array[i])]], merge: true)
        }
        
        view.window?.rootViewController = allergies
        view.window?.makeKeyAndVisible()
    }

}
