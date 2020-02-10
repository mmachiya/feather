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

    struct SignUpUser {
        static let db = Firestore.firestore()
        static var userAuthToken = String()
        static var skinSensitivity = Int()
        static var skinTypeLevel = Int()
        static var acneLevel = Int()
        static var age = Int()
        static var allergies = [String]()
        static var badProducts = [String]()
        static var journal = [Date:UIImage]()
        static var products = [String]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

