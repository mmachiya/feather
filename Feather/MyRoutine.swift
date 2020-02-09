  
//
//  MyRoutine.swift
//  Feather
//
//  Created by Kristina Tran on 2/5/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//
  
import UIKit
import Foundation
  class MyRoutine : UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var productSearchBar: UISearchBar!
    @IBOutlet weak var productTagleView: UITableView!
    @IBOutlet weak var textOutput: UITextView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
  }
