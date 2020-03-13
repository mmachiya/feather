//
//  MainMenu.swift
//  Feather
//
//  Created by Kristina Tran on 1/23/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

var firstTime = true;
class MainMenu: UIViewController, LoginButtonDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("nobody should call this")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("nobody should call this")
    }
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        if AccessToken.current == nil {
           print("fb not logged in, logged in with google")
           GIDSignIn.sharedInstance().signOut()
        } else {
            print("fb logged in")
            let loginManager = LoginManager()
            loginManager.logOut()
        }
        if Auth.auth().currentUser != nil {
            print("user is not nil")
        }
        else {
            print("user is nil")
        }
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        if Auth.auth().currentUser != nil {
            print("user is not nil")
        }
        else {print("user is nil")}
        transitionStart()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logging out")
        if AccessToken.current == nil {
           print("we out herefb")
        }
        if Auth.auth().currentUser != nil {
            print("user is not nil")
        }
        else {
            print("user is nil")
        }
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        if Auth.auth().currentUser != nil {
            print("user is not nil")
        }
        else {print("user is nil")}
        LoginManager().logOut()
        if AccessToken.current == nil {
                   print("this is good fb")
        }

        transitionStart()
    }
    
//    var firstTime = true;
    
    @IBOutlet var trailing: NSLayoutConstraint!
    @IBOutlet var leading: NSLayoutConstraint!
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var logoutGmail: UIButton!
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
        if (AccessToken.current != nil){
//            print("that access for fb exists")
//            let loginButton = FBLoginButton()
//            loginButton.delegate = self
//            loginButton.center = self.view.center;
//            self.view.addSubview(loginButton);
        }
        else{
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance()?.presentingViewController = self
        }
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
    
    func transitionStart()
    {
        let SignUpScreenID = storyboard?.instantiateViewController(identifier: "SignUpScreenID") as? SignUpScreen
        
        view.window?.rootViewController = SignUpScreenID
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
