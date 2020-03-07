//
//  MainMenu.swift
//  Feather
//
//  Created by Kristina Tran on 1/23/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import UIKit
var firstTime = true;
class MainMenu: UIViewController {
//    var firstTime = true;
    
    @IBOutlet var trailing: NSLayoutConstraint!
    @IBOutlet var leading: NSLayoutConstraint!
    
    @IBOutlet weak var RPButton: UIButton!
    var menuOut = false
    @IBOutlet weak var journalButton: UIButton!
    @IBAction func journalPressed(_ sender: UIButton) {
        if (firstTime == true){
            firstTimeJournal()
        }
        else{
            transitionJournal()
        }
    }
    @IBAction func RPPressed(_ sender: UIButton) {
        restartCheck()
    }
    
    func firstTimeJournal (){
        firstTime = false
        let alert = UIAlertController(title: "Welcome to the journal!", message: "my journal is a place for you to record your daily skin journey!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in self.transitionJournal()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func restartCheck (){
        let alert = UIAlertController(title: "Are you sure?", message: "Restarting the profile may override your existing profile.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes, restart.", style: .default, handler: {(_) in self.transitionProfile()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func transitionProfile()
    {
        let skinProfileVC = storyboard?.instantiateViewController(identifier: "SkinProfileVC") as? SkinProfile
        
        view.window?.rootViewController = skinProfileVC
        view.window?.makeKeyAndVisible()
    }
    
    func transitionJournal()
    {
        let JournalVC = storyboard?.instantiateViewController(identifier: "JournalVC") as? EntryCollectionViewController
        
        view.window?.rootViewController = JournalVC
        view.window?.makeKeyAndVisible()
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
