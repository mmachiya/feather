//
//  AppDelegate.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 10/28/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn



//var productsCollection: RemoteMongoCollection<FeatherProduct>

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var sign = SignUpScreen()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // google sign-in
        FirebaseApp.configure()

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // window set up
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: SignUpScreen())
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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
                print("wah")
                Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {
                    print("EROROJE!!!")
                    print(error.localizedDescription)
                    return
                  }
//                    let skinProfileVC = self.storyboard.instantiateViewController(identifier: "SkinProfileVC") as! SkinProfile
//                    let mainStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
//                    let test = mainStoryBoard.instantiateViewController(withIdentifier: "SkinProfileVC")
//                    self.window?.rootViewController = test
                    print("signed in successfully")
                    self.sign.proceed()
//                    self.UIViewController.performSegue(withIdentifier: "toBuildProfile")
//                    self.window?.makeKeyAndVisible()
//                    UserDefaults.standard.set(link, forKey: "Link")
//                    (self.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: false)
//                    self.window?.rootViewController?.performSegue(withIdentifier: "mjn", sender: nil)
//                    let rootViewController = self.window!.rootViewController as! UINavigationController;
//                    rootViewController.pushViewController(test, animated: true)
//                    self.window?.rootViewController?.performSegue(withIdentifier: "toBuildProfile", sender: SignUpScreen.self)
                }
            }

        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            // Perform any operations when the user disconnects from app here.
            // ...
        }
        
}

    




