//
//  FeatherTests.swift
//  FeatherTests
//
//  Created by Siriwan Sereesathien on 3/11/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import XCTest
@testable import Feather

class FeatherTests: XCTestCase {

    func testSkinProfileValidateAgeEmpty()
    {
        let skinprofile = SkinProfile()
        let err: String = skinprofile.validateAge(ageString:"")!
        print("ERR: " + err)
        
        XCTAssertEqual(err, "Please enter an age.")
    }
    
    func testSkinProfileValidateAgeNegative()
    {
        let skinprofile = SkinProfile()
        let err: String = skinprofile.validateAge(ageString:"-20")!
        
        XCTAssertEqual(err, "Please enter a positive whole number")
    }
    
    func testSkinProfileValidateAgeUnder13()
    {
        let skinprofile = SkinProfile()
        let err: String = skinprofile.validateAge(ageString:"12")!
        
        XCTAssertEqual(err, "This app is recommended for people ages 13 and up.")
    }
    
    func testSkinProfileValidateAgeOld()
    {
        let skinprofile = SkinProfile()
        let err: String = skinprofile.validateAge(ageString:"120")!
        
        XCTAssertEqual(err, "Are you sure? Your age is awfully high, please re-enter.")
    }
}
