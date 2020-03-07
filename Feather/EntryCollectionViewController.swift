//
//  EntryCollection.swift
//  Feather
//
//  Created by Mirei on 1/20/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//


import UIKit

var journalEntries: [Date:UIImage] = [:]

class EntryCollectionViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var entries: [Date:UIImage] = [:]
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBAction func plusAction(_ sender: UIButton) {
        if (Calendar.current.isDateInToday(mostRecentEntryDate)){
            onePerDay()
        }
        else{
            print("DEATH")
            self.performSegue(withIdentifier: "death", sender: nil)
        }
        
    }
    
    func onePerDay (){
        let alert = UIAlertController(title: "Error", message: "You already made a journal entry today.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return journalEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.selfieImageView.image = Array(journalEntries.values)[indexPath.row]
        print ("TRIED TO DISPLAY CELL")
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: self.collectionView.frame.size.width/3, height: self.collectionView.frame.size.height/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
       }
    
    
}
