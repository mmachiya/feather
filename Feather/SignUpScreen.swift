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
import FBSDKCoreKit
import FBSDKLoginKit
class SignUpScreen: UIViewController, LoginButtonDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var `continue`: UIButton!
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if ((error) != nil) {
                // Process error
            }
            else if result!.isCancelled {
                // Handle cancellations
            }
            else {
                print("we in this bitch")
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                
                ViewController.SignUpUser.userAuthUID = Auth.auth().currentUser!.uid
                ViewController.SignUpUser.currentCollection = Auth.auth().currentUser!.uid
                
                ViewController.SignUpUser.db.collection(Auth.auth().currentUser!.uid).document(Auth.auth().currentUser!.uid)
                
                Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {
                    print(error)
                    return
                  }
                  // User is signed in
                  print("im here")
                  self.performSegue(withIdentifier: "hehe", sender: nil)
                }

            }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("user logged out")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("did load")
        GIDSignIn.sharedInstance().delegate = self
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.center = self.view.center;
        self.view.addSubview(loginButton);
        GIDSignIn.sharedInstance()?.presentingViewController = self

    }
    
    deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
    @IBAction func didTapSignOut(_ sender: AnyObject) {
      GIDSignIn.sharedInstance().signOut()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {

        print("sdkjflaskdjflak")
          if let error = error {
            print("ERRORRRR!!!")
            print(error.localizedDescription)
            return
          }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        ViewController.SignUpUser.userAuthUID = Auth.auth().currentUser!.uid
        ViewController.SignUpUser.currentCollection = Auth.auth().currentUser!.uid
        
        print("UID ===========>" + ViewController.SignUpUser.userAuthUID)
        ViewController.SignUpUser.db.collection(Auth.auth().currentUser!.uid).document(Auth.auth().currentUser!.uid)
        
        print("wah")
        print("AUTHENTICATION TOKEN ID" + authentication.idToken!)
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            print("EROROJE!!!")
            print(error.localizedDescription)
            return
          }

            print("signed in successfully")
            if (GIDSignIn.sharedInstance()?.currentUser != nil) {
                print("what is this!")
                self.performSegue(withIdentifier: "hehe", sender: nil)
            }
            else {
                print("Boo")
            }
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}
