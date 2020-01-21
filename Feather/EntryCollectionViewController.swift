//
//  EntryCollection.swift
//  Feather
//
//  Created by Mirei on 1/20/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

//import Foundation
import UIKit
//struct Date

//struct EntryCollection {
//    var entries: [Date:UIImage] = [:]
//
//    mutating func addEntry(image : UIImage){
//        self.entries[Date()] = image
//    }
//}
var journalEntries: [Date:UIImage] = [:]

class EntryCollectionViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var entries: [Date:UIImage] = [:]
    @IBOutlet weak var collectionView: UICollectionView!
//    let backgroundImageView = UIImageView()
    
//    func setBackground(){
//        view.addSubview(backgroundImageView)
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        backgroundImageView.image = UIImage(named: "topBarGreen")
//
//        view.sendSubviewToBack(backgroundImageView)
//    }
    
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
    
//    func addEntry(image : UIImage){
//        entries[Date()] = image
//    }
    
    
    
}
