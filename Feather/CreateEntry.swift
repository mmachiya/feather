//
//  CreateEntry.swift
//  Feather Journal Base
//
//  Created by Mirei on 11/14/19.
//  Copyright © 2019 Feather. All rights reserved.
//

import UIKit
import FirebaseStorage

var mostRecentEntryDate = Date(timeIntervalSinceReferenceDate: -123456789.0)

class CreateEntry: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    


    let collection = ViewController.SignUpUser.currentCollection
    let doc = ViewController.SignUpUser.userAuthUID
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func onePerDay (){
        let alert = UIAlertController(title: "Sorry", message: "You already selected an image!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var selfieButton: UIButton!
    @IBAction func ChooseSelfie(_ sender: Any) {
        if (Calendar.current.isDateInToday(mostRecentEntryDate)){
            onePerDay()
        }
        else{
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source.", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
                if UIImagePickerController.isSourceTypeAvailable(.camera)
                {
                    imagePicker.sourceType = .camera
                    self.present(imagePicker, animated: true, completion: nil)
                } else {
                    print("Camera not found.")
                    let alert = UIAlertController(title: "No camera found.", message: "Camera cannot be accessed.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }))
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action: UIAlertAction) in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true,  completion: nil)
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(actionSheet, animated: true, completion: nil)
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (!Calendar.current.isDateInToday(mostRecentEntryDate)){
            let image = info[.originalImage] as! UIImage
                imageView.image = image
      
                journalEntries[Date()] = image
                mostRecentEntryDate = Date()
                print (mostRecentEntryDate)
                //ATTEMPTING TO STORE IMAGE
                guard let data = image.jpegData(compressionQuality: 1.0)
                else {
                    print("Error with getting image")
                    return
                }
                let imageName = UUID().uuidString
                
                let imageReference = Storage.storage().reference().child("journalFolder").child(imageName)
                
                imageReference.putData(data, metadata: nil) {
                    (metadata, err) in
                    if let err = err
                    {
                        print("Error " + err.localizedDescription)
                        return
                    }
                    imageReference.downloadURL(completion: {
                        (url, err) in
                        if let err = err
                        {
                            print ("Error " + err.localizedDescription)
                            return
                        }
                        guard let url = url else {
                            print ("Error: Something wrong with url")
                            return
                        }
                        
                        let dataReference = ViewController.SignUpUser.db.collection(self.collection).document(self.doc)
                                        
                        let urlString = url.absoluteString
                        
                        let currentDate = Date().description
            
                        ViewController.SignUpUser.journal[currentDate] = urlString
                        
                        dataReference.setData(["journal":[currentDate:urlString]], merge: true)
                    })
                }
         
                picker.dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    


}

