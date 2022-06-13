//
//  UsernameViewController.swift
//  Unify
//
//  Created by Melvin Asare on 04/10/2021.
//

import UIKit

class CreateUsernameViewController: OnboardingViewController {

    private let usernameTextField: UnifyTextField = {
        let textField = UnifyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.please_enter_your_full_name, color: .gray, textAlignment: .left, isSecureTextEntry: false)
        textField.textColor = .unifyGray
        return textField
    }()

    override func continueButtonTapped() {
        if usernameTextField.text?.isEmpty == true {
            self.presentAlert(title: Unify.strings.error, message: UnifyErrors.invalidUsername.rawValue, buttonTitle: Unify.strings.ok)
            return
        }

        if isUsernameValidLength(usernameTextField.text ?? "") {
            viewModel.addUsernameToDatabase(name: usernameTextField.text ?? "") { [weak self] success in
                if success == .completed {
                    self?.viewModel.saveOnboardingState(stringValue: "username", is_stage_complete: "complete", isOnboardingComplete: false, userId: self?.viewModel.currentUserId! ?? "failed no user", completion: { [weak self] success in
                        if success {
                            self?.navigationController?.pushViewController(UserProfileImageViewController(viewModel: OnboardingViewModel()), animated: true)
                        } else {
                            self?.presentAlert(title: Unify.strings.error, message: UnifyErrors.genericError.rawValue, buttonTitle: Unify.strings.restart)
                        }
                    })
                }
            }
        }
    }

    private let viewModel: OnboardingViewModel

    required init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Unify.strings.whats_your_name
        view.addSubview(usernameTextField)

        usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72).isActive = true
        continueButton.isHidden = false
    }
}
