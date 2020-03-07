//
//  ViewController.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 10/28/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {
    
    var loadingData = true
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    struct SignUpUser {
        static let db = Firestore.firestore()
        static var currentCollection = String() //same as userAuthUID
        static var userAuthUID = String()
        static var skinSensitivity = Int()
        static var skinTypeLevel = Int()
        static var acneLevel = Int()
        static var age = Int()
        static var allergies = [String]()
        static var badProducts = [String]()
        static var journal = [String:String]()
        static var products = [String]()
    }
    
    struct Database{
        static var products = [ProductInfo]()
        static var ingredients = [String]()
        static var productsString = [String]()
    }
    
    override func viewDidLoad() {
        downloadProductData()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        while loadingData
        {
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.medium
            view.addSubview(activityIndicator)
            // ADD POP UP HERE
            activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
        if !loadingData
        {
            activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            transitionNext()
        }
    }
    
    
    func downloadProductData()
    {
        let url = URL(string: "https://raw.githubusercontent.com/mmachiya/feather/master/WebScraping/newulta2.json")
        URLSession.shared.dataTask(with: url!)
        {
            (data, response, error) in
                do
                {
                    print("before parsing json")
                    Database.products = try JSONDecoder().decode([ProductInfo].self, from: data!)
                    print("past json decoder")
                    for prod in Database.products
                    {
                        if !Database.productsString.contains(prod.name)
                        {
                            let tempname: String = prod.brand + " " + prod.name
                            Database.productsString.append(tempname)
                        }
                        
                        for i in prod.self.ingredients
                        {
                            if !Database.ingredients.contains(i)
                            {
                                Database.ingredients.append(i)
                            }
                        }
                    }
                    Database.ingredients.sort()
                    Database.productsString.sort()
                    print("GOT ALL DATA FROM DATABASE")
                    self.loadingData = false
                }
                catch
                {
                    print("My JSON Decoding Error")
                }
        }.resume()
    }
    func transitionNext()
    {
        let signup = storyboard?.instantiateViewController(identifier: "SignUpScreen") as? SignUpScreen
        
        view.window?.rootViewController = signup
        view.window?.makeKeyAndVisible()
    }
}

