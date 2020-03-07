//
//  SkinProfile.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 10/28/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit

class SkinProfile: UIViewController {
    
    let collection = ViewController.SignUpUser.currentCollection
    let doc = ViewController.SignUpUser.userAuthUID
    
    var ageValue: Int = 0
    var dryOilyValue: Int = 50
    var sensitivityValue: Int = 50
    var acneValue: Int = 50

    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var SkinTypeSlider: UISlider!
    @IBOutlet weak var SkinSensitivitySlider: UISlider!
    @IBOutlet weak var AcneSlider: UISlider!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("appeared!")
        self.storyboard?.instantiateViewController(withIdentifier: "SkinProfileVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dismisses the number pad for age
        let tap = UITapGestureRecognizer(target: self.view,action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        if ViewController.SignUpUser.age != 0
        {
            populate()
        }
        
        ViewController.SignUpUser.skinTypeLevel = Int(SkinTypeSlider.value)
        dryOilyValue = Int(SkinTypeSlider.value)
        ViewController.SignUpUser.skinSensitivity = Int(SkinSensitivitySlider.value)
        sensitivityValue = Int(SkinSensitivitySlider.value)
        ViewController.SignUpUser.acneLevel = Int(AcneSlider.value)
        acneValue = Int(AcneSlider.value)
        
        // make the error label transparent
        errorLabel.alpha = 0

    }

    @IBAction func dryOilySlider(_ slider: UISlider)
    {
        dryOilyValue = Int(slider.value)
        ViewController.SignUpUser.skinTypeLevel = dryOilyValue
    }
    
    @IBAction func sensitivitySlider(_ slider: UISlider)
    {
        sensitivityValue = Int(slider.value)
        ViewController.SignUpUser.skinSensitivity = sensitivityValue

    }
    
    @IBAction func acneSlider(_ slider: UISlider)
    {
        acneValue = Int(slider.value)
        ViewController.SignUpUser.acneLevel = acneValue
    }
    
    @IBAction func nextButtonTapped(_ button: UIButton)
    {
        
        ViewController.SignUpUser.db.collection(collection).document(doc).setData(["skinTypeLevel":dryOilyValue], merge: true)
        print(dryOilyValue)
        ViewController.SignUpUser.db.collection(collection).document(doc).setData(["skinSensitivity":sensitivityValue], merge: true)
        print(sensitivityValue)
        ViewController.SignUpUser.db.collection(collection).document(doc).setData(["acneLevel":acneValue], merge: true)
        print(acneValue)
        
        let error = validateAge()
        if error != nil
        {
            showError(error!)
        }
        else
        {
            transitionNext()
         }
    }
    
    func validateAge() -> String?
    {
        // check if age is filled
        if ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please enter an age."
        }
        
        // check if the age is a valid number
        let ageString: String = ageTextField.text ?? "-1"
        let ageInt: Int = Int(ageString) ?? -1
        var old: Bool = false
        
        if ageInt < 0
        {
            return "Please enter a positive whole number"
        }
        else if ageInt < 13
        {
            return "This app is recommended for people ages 13 and up."
        }
        else if ageInt >= 100
        {
            return "Are you sure? Your age is awfully high, please re-enter."
        }
        // if nothing is wrong we are setting the global ageValue here
        ageValue = ageInt
        ViewController.SignUpUser.age = ageValue
        ViewController.SignUpUser.db.collection(collection).document(doc).setData(["age":ageValue], merge: true)
        return nil
    }
    
    
    func showError(_ message:String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionNext()
    {
        let rankingVC = storyboard?.instantiateViewController(identifier: "RankingVC") as? Ranking
        
        view.window?.rootViewController = rankingVC
        view.window?.makeKeyAndVisible()
    }
    
    func populate()
    {
        SkinTypeSlider.setValue(Float(ViewController.SignUpUser.skinTypeLevel), animated: true)
        SkinSensitivitySlider.setValue(Float(ViewController.SignUpUser.skinSensitivity), animated: true)
        AcneSlider.setValue(Float(ViewController.SignUpUser.acneLevel), animated: true)
        ageTextField.text = String(ViewController.SignUpUser.age)
    }
}
