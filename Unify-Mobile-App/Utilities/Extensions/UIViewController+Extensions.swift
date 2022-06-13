//
//  UIViewController+Extensions.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 13/05/2021.
//

import UIKit
import SearchTextField
import Floaty

extension UIViewController {
    
    public func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }

    public func addToView(_ childViewController: UIViewController,
                          addChildView: Bool = true,
                          constrainToSuperview: Bool = true) {
        addChild(childViewController)

        if addChildView {
            view.addSubview(childViewController.view)
        }
        childViewController.didMove(toParent: self)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        childViewController.view.constrain(to: view)
    }
    
    func setErrors(error: String) {
        switch error {
        case "The email address is already in use by another account.":
            return presentAlert(title: "Error", message: UnifyErrors.emailAlreadyExist.rawValue, buttonTitle: "Ok")
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
            return presentAlert(title: "Error", message: UnifyErrors.noUserRegistered.rawValue, buttonTitle: "Ok")
        case "The email address is badly formatted.":
            return presentAlert(title: "Error", message: UnifyErrors.invalidEmail.rawValue, buttonTitle: "Ok")
        case "The password is invalid or the user does not have a password.":
            return presentAlert(title: "Error", message: UnifyErrors.invalidPassword.rawValue, buttonTitle: "Ok")
        default:
            presentAlert(title: Unify.strings.error, message: UnifyErrors.genericError.rawValue, buttonTitle: Unify.strings.ok)
        }
    }

    public func convertEnumToString(state: OnboardingStateProgressEnum) -> String {
        switch state {
        case .completed:
            return "completed"
        case .uncomplete:
            return "uncomplete"
        }
    }
    
    func isCurrentUser(currentUserId: String, userId: String) -> Bool {
        if currentUserId == userId {
            return true
        }
        return false
    }

    public func removeBarButtonItems() {
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = leftBarButton
    }

    public func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }

    public func isPasswordValid(password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        return passwordTest.evaluate(with: password)
    }

    public func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    public func isUsernameValidLength(_ username: String) -> Bool {
        if username.count < 3 {
            return false
        }
        return true
    }

    public struct Consts {
        static let floatingButtonWidth: CGFloat = 52.0
        static let floatingButtonPadding: CGFloat = 28.0
    }

    public func setFloatyConstraints(view: UIView, button: Floaty) {
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Consts.floatingButtonPadding).isActive = true
        button.heightAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true
        button.widthAnchor.constraint(equalToConstant: Consts.floatingButtonWidth).isActive = true
    }

    public func hasSpecChars(text: String) -> Bool {
        var invalidChars = CharacterSet.letters
        invalidChars.insert(charactersIn: " ")
        invalidChars.invert()
        let acceptedChars = text.trimmingCharacters(in: invalidChars)
        return acceptedChars.count < text.count
    }

    public func removeWhiteSpace(text: String) -> String {
        let modifiedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return modifiedText
    }

    func filterThroughCourses(to filter: [Course], courseTextField: SearchTextField) {
        let courseName = filter.compactMap { $0.name }
        courseTextField.filterStrings(courseName)
        courseTextField.theme.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        courseTextField.theme.fontColor = .darkGray
        courseTextField.theme.font = UIFont.systemFont(ofSize: 18)
        courseTextField.theme.cellHeight = 50
        courseTextField.theme.borderColor  = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        courseTextField.comparisonOptions = [.caseInsensitive]
    }

    func filterThroughUniversity(to filter: [University], universityTextField: SearchTextField) {
        let universityName = filter.compactMap { $0.name }
        universityTextField.filterStrings(universityName)
        universityTextField.theme.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        universityTextField.theme.fontColor = .darkGray
        universityTextField.theme.font = UIFont.systemFont(ofSize: 18)
        universityTextField.theme.cellHeight = 50
        universityTextField.theme.borderColor  = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        universityTextField.comparisonOptions = [.caseInsensitive]
    }

    func filterThroughYear(to filter: [StudyYear], studyYearTextField: SearchTextField) {
        let studyYear = filter.compactMap { $0.year }
        studyYearTextField.filterStrings(studyYear)
        studyYearTextField.theme.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        studyYearTextField.theme.fontColor = .darkGray
        studyYearTextField.theme.font = UIFont.systemFont(ofSize: 18)
        studyYearTextField.theme.cellHeight = 50
        studyYearTextField.theme.borderColor  = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        studyYearTextField.comparisonOptions = [.caseInsensitive]
    }

    public func presentAlert(title: String, message: String, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alert = UIAlertAction(title: buttonTitle, style: .default)
        alertController.addAction(alert)
        self.present(alertController, animated: true)
    }

    public func signOut() {
//        AccountManager.account.signOut { [weak self] success in
//            if success {
//                let viewModel = OnboardingViewModel()
//                let viewController = LoginViewController(viewModel: viewModel)
//                self?.navigationController?.pushViewController(viewController, animated: true)
//            }
//        }
    }
}


