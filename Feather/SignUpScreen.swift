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
    @IBOutlet weak var continue2: UIButton!
    var handle: AuthStateDidChangeListenerHandle?
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
            if let error = error {
              print(error.localizedDescription)
              return
            }
          guard let authentication = user.authentication else { return }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                         accessToken: authentication.accessToken)
          Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
              print(error.localizedDescription)
              return
            }
            let docRef = ViewController.SignUpUser.db.collection(Auth.auth().currentUser!.uid).document(Auth.auth().currentUser!.uid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    print("user has a firebase account already, and is skipping profile")
                    if(GIDSignIn.sharedInstance().hasPreviousSignIn()){
                      GIDSignIn.sharedInstance().restorePreviousSignIn()}
                    self.performSegue(withIdentifier: "hehe2", sender: nil)
                } else {
                    ViewController.SignUpUser.userAuthUID = Auth.auth().currentUser!.uid
                    ViewController.SignUpUser.currentCollection = Auth.auth().currentUser!.uid
                    print("UID ===========>" + ViewController.SignUpUser.userAuthUID)
                    ViewController.SignUpUser.db.collection(Auth.auth().currentUser!.uid).document(Auth.auth().currentUser!.uid)
                    print("AUTHENTICATION TOKEN ID" + authentication.idToken!)
                    self.performSegue(withIdentifier: "hehe", sender: nil)
                    print("Document does not exist for this user.")
                    print("headed to profile now for the first time")
                    self.performSegue(withIdentifier: "hehe", sender: nil)
                }
            }
        }
      }

      func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
          // Perform any operations when the user disconnects from app here.
          // ...
      }
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if ((error) != nil) {
                // Process error
            }
            else if result!.isCancelled {
                // Handle cancellations
            }
            else {
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)

                Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {
                    print(error)
                    return
                  }
                  let docRef = ViewController.SignUpUser.db.collection(Auth.auth().currentUser!.uid).document(Auth.auth().currentUser!.uid)
                  docRef.getDocument { (document, error) in
                      if let document = document, document.exists {
                          let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                          print("Document data: \(dataDescription)")
                          print("user has a firebase account already, and is skipping profile")
                          self.performSegue(withIdentifier: "hehe2", sender: nil)
                      } else {
                          print("Document does not exist for this user.")
                          ViewController.SignUpUser.userAuthUID = Auth.auth().currentUser!.uid
                          ViewController.SignUpUser.currentCollection = Auth.auth().currentUser!.uid
                          ViewController.SignUpUser.db.collection(Auth.auth().currentUser!.uid).document(Auth.auth().currentUser!.uid)
                           print("headed to profile now for the first time")
                          self.performSegue(withIdentifier: "hehe", sender: nil)
                      }
                  }
                    
                }
                
            }
            }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("user logged out")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.center = self.view.center;
        self.view.addSubview(loginButton);
        GIDSignIn.sharedInstance()?.presentingViewController = self

    }
    override func viewDidAppear(_ animated: Bool) {
     if Auth.auth().currentUser != nil {
        // User is signed in.
        // ...
        print("sending you to main menu")
        self.performSegue(withIdentifier: "hehe2", sender: nil)
    } else {
        print("user is not signed in")
    }
    }
    deinit {
            NotificationCenter.default.removeObserver(self)
    }
}
