//
//  SignUpScreen.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 10/30/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit
import MongoSwift
import GoogleSignIn
import Firebase

class SignUpScreen: UIViewController {
        

    override func viewDidLoad() {
        super.viewDidLoad()
        print("did load")

        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance().signIn()
        if (GIDSignIn.sharedInstance()?.currentUser != nil) {
                   print("yay")
                   transitionNext()
               }
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func proceed(){
        if (GIDSignIn.sharedInstance()?.currentUser != nil) {
            print("yay!")
            transitionNext()
        }
        else {
            print("Boo")
        }
    }
    
    func transitionNext()
    {
        print("we in trans")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let test = storyboard.instantiateViewController(withIdentifier: "SkinProfileVC")
        
//        navigationController?.pushViewController(test, animated: true)
        
//        (self.rootViewController as? UINavigationController).pushViewController(test, animated: true)
        //let profileVC = storyboard?.instantiateViewController(withIdentifier: "SkinProfileVC") as! SkinProfile
        
        //self.present(profileVC, animated: true, completion: nil)
        regSegue()
        
//        self.view.window?.rootViewController = profileVC
//        self.view.window?.makeKeyAndVisible()
//        performSegue(withIdentifier: "mjn", sender: self)
        print("weleavingtrans")
    }
    func regSegue(){
        let page = SkinProfile()
        getTopMostViewController()?.present(page, animated: true, completion: nil)
//        topViewController: UIViewController?
//        topViewController?.present(page, animated: true, completion: nil)
    }
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController

        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }

        return topMostViewController
    }
    @IBAction func didTapSignOut(_ sender: AnyObject) {
      GIDSignIn.sharedInstance().signOut()
    }
}
