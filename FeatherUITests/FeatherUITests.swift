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
        let app = XCUIApplication()
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCancelGoogle() {
        //let app = XCUIApplication()
        app.launch()
        app.buttons["get started"].tap()
        //app/*@START_MENU_TOKEN@*/.buttons["GIDSignInButton"]/*[[".buttons[\"Sign in\"]",".buttons[\"GIDSignInButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.twoFingerTap()
        //app.alerts["“Feather” Wants to Use “google.com” to Sign In"].scrollViews.otherElements.buttons["Continue"].tap()
        
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
class LoginTests:XCTestCase{
    var app: XCUIApplication!
    
    func testLogin() {
      continueAfterFailure = false
      app = XCUIApplication()
      app.launch()
      passLogin()
    }
}
extension LoginTests {
  func passLogin() {
    // Tap login
    //app.buttons["get started"].twoFingerTap()
    app.showFacebookLoginFormButton.tap()
//    wait(for: app.alerts.buttons["Continue"],timeout: 10)
//    app.alerts.buttons["Continue"].tap()
    
    wait(for: app.staticTexts["Facebook"], timeout: 30) // This requires a high timeout


    if app.isAlreadyLoggedInSafari {
      app.okButton.tap()

     XCTAssert(app.staticTexts["build your profile"].exists)
      // Need to interact with the app for interruption monitor to work
      app.tap()
    } else {
      // Choose norsk
     wait(for: app.norwegianText, timeout: 1)
      app.norwegianText.tap()

      app.emailTextField.tap()
        app.emailTextField.typeText("dgmzssjgpw_1583955457@tfbnw.net")

      app.passwordCoordinate.tap()
      app.typeText("Emily Aldhcaibgidgg Smithsen")

      // login
      app.facebookLoginButton.tap()

      // press OK
      app.okButton.tap()

      XCTAssert(app.staticTexts["build your profile"].exists)

      // Need to interact with the app for interruption monitor to work
      app.tap()
    }
  }

}
extension LoginTests {

    // I hope this code is mostly reusable
    // I didn't test it for Location Permission While in Use vs. Always...
    func setPermission(for alert:XCUIElement, allow: Bool) -> Bool {
        if alert.elementType == .alert {

            // make sure to support any language
            // Might also be "allow" for some dialogs
            let buttonIdentifier = allow ? "Continue" : "Cancel"
            let identifierButton = alert.buttons[buttonIdentifier]
            if identifierButton.exists && identifierButton.isHittable {
                identifierButton.tap()
                return true
            }

            // Or, if you don't want to bother with the language/identifiers
            // Allow = Last button Index (probably 1), Cancel = 0
            let buttonIndex = allow ? alert.buttons.count - 1 : 0
            let indexButton = alert.buttons.element(boundBy: buttonIndex)
            if indexButton.exists && indexButton.isHittable {
                indexButton.tap()
                return true
            }
        }
        return false
    }
}
fileprivate extension XCUIApplication {
  var showFacebookLoginFormButton: XCUIElement {
    return buttons["Continue with Facebook"]
  }

  var isAlreadyLoggedInSafari: Bool {
    return buttons["OK"].exists || staticTexts["Du har allerede godkjent Blue Sea."].exists
  }

  var okButton: XCUIElement {
    return buttons["OK"]
  }

  var norwegianText: XCUIElement {
    return staticTexts["Norsk (bokmål)"]
  }

  var emailTextField: XCUIElement {
    let predicate = NSPredicate(format: "placeholderValue == %@", "E-post eller mobil")
    return textFields.element(matching: predicate)
  }

  var passwordCoordinate: XCUICoordinate {
    let vector = CGVector(dx: 1, dy: 1.5)
    return emailTextField.coordinate(withNormalizedOffset: vector)
  }

  var facebookLoginButton: XCUIElement {
    return buttons["Logg inn"]
  }
}

extension XCTestCase {
  func wait(for duration: TimeInterval) {
    let waitExpectation = expectation(description: "Waiting")

    let when = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: when) {
      waitExpectation.fulfill()
    }

    // We use a buffer here to avoid flakiness with Timer on CI
    waitForExpectations(timeout: duration + 0.5)
  }

  /// Wait for element to appear
  func wait(for element: XCUIElement, timeout duration: TimeInterval) {
    let predicate = NSPredicate(format: "exists == true")
    let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)

    // We use a buffer here to avoid flakiness with Timer on CI
    waitForExpectations(timeout: duration + 0.5)
  }
}

extension XCUIApplication {
  // Because of "Use cached accessibility hierarchy"
  func clearCachedStaticTexts() {
    let _ = staticTexts.count
  }

  func clearCachedTextFields() {
    let _ = textFields.count
  }

  func clearCachedTextViews() {
    let _ = textViews.count
  }
}

