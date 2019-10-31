//
//  SignUpScreen.swift
//  Feather
//
//  Created by Siriwan Sereesathien on 10/30/19.
//  Copyright © 2019 CSC308_309. All rights reserved.
//

import UIKit

class SignUpScreen: UIViewController {
    
    // TODO store it somewhere else
    var username: String = ""
    var password: String = ""

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPwdTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dismisses the number pad for age
        let tap = UITapGestureRecognizer(target: self.view,action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // make the error label transparent
        errorLabel.alpha = 0
    }
    
    @IBAction func signUpTapped(_ sender: UIButton)
    {
        let error = validateFields()
        if error != nil
        {
            showError(error!)
        }
        else
        {
            transitionNext()
        }
    }
    
    func validateFields() -> String?
    {
        // check if all the fields are filled in
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || confirmPwdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all the fields."
        }
        
        // check matching passwords for confirmation
        if (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) != (confirmPwdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))
        {
            return "The passwords do not match, please re-enter."
        }
        
        // TODO values of username and password to be stored in db
        username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        return nil
    }
    
    func showError(_ message:String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionNext()
    {
        let skinProfileVC = storyboard?.instantiateViewController(identifier: "SkinProfileVC") as? SkinProfile
        
        view.window?.rootViewController = skinProfileVC
        view.window?.makeKeyAndVisible()
    }
}
