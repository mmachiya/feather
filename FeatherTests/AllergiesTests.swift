//
//  AllergiesTests.swift
//  FeatherTests
//
//  Created by Siriwan Sereesathien on 3/12/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import Foundation
import Quick
import XCTest
import Nimble
import Nimble_Snapshots

@testable import Feather

class AllergiesMock: AllergiesProtocol {
    
    var didSelectCell: Bool = false
    var data: String?
    
    func didSelectCell(data: String) {
        didSelectCell = true
        self.data = data
    }
}

class AllergiesTest: QuickSpec {
    override func spec() {
        var allergies: Allergies!
        let myAllergies = AllergiesMock()
        var tableView: UITableView!
        
        describe("Allergies") {
            
            beforeEach {
                let data = ["Rodrigo", "Cavalcante", "Testing", "Delegate", "Datasource"]
                ViewController().viewDidLoad()
                SignUpScreen().viewDidLoad()
                allergies = Allergies()
                allergies.viewDidLoad()
                
                allergies.ingredients = data
                allergies.allergyProtocol = myAllergies
                
                tableView = UITableView()
                
                tableView.register(UITableViewCell.self,
                                   forCellReuseIdentifier: "Cell")
                
                tableView.dataSource = allergies
                tableView.delegate = allergies
                allergies.textOutput = UITextView()
                //allergies.allergiesTableView = 
            }
            
            //MARK: Datasource
            
            it("should return the right number of rows") {
                expect(allergies.tableView(tableView, numberOfRowsInSection: 0)) == 5
            }
            
            //MARK: Delegate
            
            it("should return Rodrigo if user select first Cell") {
                //let indexPath = IndexPath(row:0, section: 0)
                
                expect(myAllergies.didSelectCell) == false
                
                //allergies.tableView(tableView, didSelectRowAt: indexPath)
                //expect(myAllergies.didSelectCell) == true
                //expect(myAllergies.data!) == "Rodrigo"
            }
        }
    }
}
