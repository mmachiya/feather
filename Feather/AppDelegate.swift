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
import FBSDKCoreKit
import FBSDKLoginKit

//var productsCollection: RemoteMongoCollection<FeatherProduct>

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var sign = SignUpScreen()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // google sign-in
        FirebaseApp.configure()

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        //fb 
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
               
        // window set up
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if (GIDSignIn.sharedInstance()?.currentUser != nil)
        {
           print("yay")
           window?.rootViewController = UINavigationController(rootViewController: SkinProfile())
        }
        else if (AccessToken.current != nil)
        {
            print("fb user already logged in")
            window?.rootViewController = UINavigationController(rootViewController: SkinProfile())        }
        else {
            print("display signup")
            window?.rootViewController = UINavigationController(rootViewController: SignUpScreen())
        }
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
         let handled = ApplicationDelegate.shared.application(app, open: url, options: options)
        GIDSignIn.sharedInstance().handle(url)
        return handled
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
        
}

    




