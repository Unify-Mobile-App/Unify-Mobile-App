//
//  Unify_Mobile_AppTests.swift
//  Unify-Mobile-AppTests
//
//  Created by Melvin Asare on 29/05/2022.
//

import XCTest
import Nimble

@testable import Unify_Mobile_App

class UIViewControllerExtensionTests: XCTestCase {

    private var viewController: UIViewController!
    private let username = "melvinAsare"
    private let password = "cfjnvv82i9denSDKMC."
    private let incorrectPassword = "1234"

    override func setUpWithError() throws {
        viewController = UIViewController()
    }

    func test_is_email_valid() throws {
        let isEmailValid = viewController.isEmailValid("melvin@gmail.com")
        expect(isEmailValid).to(equal(true))
    }

    func test_is_email_invalid() throws {
        let isEmailValid = viewController.isEmailValid("melvin.com")
        expect(isEmailValid).to(equal(false))
    }

    // TODO: Create tests to check valid is greater than x digits etc

    func test_is_safe_email() throws {
        let safeEmail = viewController.safeEmail(emailAddress: "melvin@gmail.com")
        expect(safeEmail).to(equal("melvin-gmail-com"))
    }

    func test_is_not_safe_email() throws {
        let safeEmail = viewController.safeEmail(emailAddress: "melvin+gmail.com")
        expect(safeEmail).to(equal("melvin+gmail-com"))
    }

    func test_is_password_valid() {
        let isPasswordValid = viewController.isPasswordValid(password: password)
        expect(isPasswordValid).to(equal(true))
    }

    func test_is_password_invalid() {
        let isPasswordValid = viewController.isPasswordValid(password: incorrectPassword)
        expect(isPasswordValid).to(equal(false))
    }

    func test_username_has_no_special_chars() {
        let hasSpecialChars = viewController.hasSpecChars(text: username)
        expect(hasSpecialChars).to(equal(false))
    }

    func test_username_has_special_chars() {
        let hasSpecialChars = viewController.hasSpecChars(text: "\(username))'64")
        expect(hasSpecialChars).to(equal(true))
    }

    func test_username_length_is_valid() {
        let isUsernameValid = viewController.isUsernameValidLength(username)
        expect(isUsernameValid).to(equal(true))
    }

    func test_username_length_is_invalid() {
        let isUsernameValid = viewController.isUsernameValidLength("gi")
        expect(isUsernameValid).to(equal(false))
    }

    // TODO: Fix these tests
//    func test_removed_whiteSpaces() {
//        let removedWhitespace = viewController.removeWhiteSpace(text: "Just Another Day")
//        expect(removedWhitespace).to(equal("JustAnotherDay"))
//    }
//
//    func test_contained_whiteSpaces() {
//        let containsWhitespace = viewController.removeWhiteSpace(text: "Just Another Day")
//        expect(containsWhitespace).to(equal("Just Another Day"))
//    }

    func test_is_current_user() {
        let isCurrentUser = viewController.isCurrentUser(currentUserId: "user1", userId: "user1")
        expect(isCurrentUser).to(equal(true))
    }

    func test_is_not_current_user() {
        let isCurrentUser = viewController.isCurrentUser(currentUserId: "user1", userId: "user2")
        expect(isCurrentUser).to(equal(false))
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
