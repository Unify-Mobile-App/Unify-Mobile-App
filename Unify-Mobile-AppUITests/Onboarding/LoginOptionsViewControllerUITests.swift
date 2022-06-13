//
//  LoginOptionsViewControllerUITests.swift
//  Unify-Mobile-AppUITests
//
//  Created by Melvin Asare on 29/05/2022.
//

import XCTest
import Nimble
import ViewControllerPresentationSpy

@testable import Unify_Mobile_App

class LoginOptionsViewControllerUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }

    func test_views_are_defined() {
        let loginExists = app.buttons["Log In"].exists
        let appleSignInExists = app.buttons["Sign in with Apple"].exists
        let termsOfServiceExists = app/*@START_MENU_TOKEN@*/.staticTexts["Click to read our terms of service"]/*[[".buttons[\"Click to read our terms of service\"].staticTexts[\"Click to read our terms of service\"]",".staticTexts[\"Click to read our terms of service\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists
        let subTitleExists = app.staticTexts["Different students, different universities, one place!"].exists

        expect(loginExists).to(beTruthy())
        expect(appleSignInExists).to(beTruthy())
        expect(termsOfServiceExists).to(beTruthy())
        expect(subTitleExists).to(beTruthy())
    }

    func test_terms_of_service_navigation() throws {
        let presentationVerifier = PresentationVerifier()

        let termsButtonTap = app/*@START_MENU_TOKEN@*/.staticTexts["Click to read our terms of service"]/*[[".buttons[\"Click to read our terms of service\"].staticTexts[\"Click to read our terms of service\"]",".staticTexts[\"Click to read our terms of service\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        var nextViewController: LoginOptionsViewController? = presentationVerifier.verify(animated: true, presentingViewController: loginOptionsViewController)
        XCTAssertEqual(nextViewController?.termsAndConditionsButton, "Hello!")

      //  expect(termsButtonTap).to(<#Predicate<Void>#>)
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
