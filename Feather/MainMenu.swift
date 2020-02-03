//
//  MainMenu.swift
//  Feather
//
//  Created by Kristina Tran on 1/23/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {
    
    @IBOutlet var trailing: NSLayoutConstraint!
    @IBOutlet var leading: NSLayoutConstraint!
    
    var menuOut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func menuTapped(_ sender: Any) {
        if menuOut == false {
            leading.constant = 150
            trailing.constant = -150
            menuOut = true
        }
        else {
            leading.constant = 0
            trailing.constant = 0
            menuOut = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
