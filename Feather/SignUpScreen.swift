//
//  SignUpScreen.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 10/30/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class SignUpScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("did load")

        GIDSignIn.sharedInstance()?.presentingViewController = self
        if (GIDSignIn.sharedInstance()?.currentUser != nil)
        {
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
        
        func transitionNext(){
            let page = SkinProfile()
            getTopMostViewController()?.present(page, animated: true, completion: nil)
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
