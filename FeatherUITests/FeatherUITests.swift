//
//  FeatherUITests.swift
//  FeatherUITests
//
//  Created by Mirei on 2/3/20.
//  Copyright © 2020 CSC308_309. All rights reserved.
//

import XCTest

class FeatherUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        continueAfterFailure = false
//        let app = XCUIApplication()
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCancelGoogle() {
//        THIS FAILS
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["get started"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["GIDSignInButton"]/*[[".buttons[\"Sign in\"]",".buttons[\"GIDSignInButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["“Feather” Wants to Use “google.com” to Sign In"].scrollViews.otherElements.buttons["Cancel"].tap()
        app.terminate()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
