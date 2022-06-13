//
//  EmailVerificationViewController.swift
//  Unify
//
//  Created by Melvin Asare on 02/03/2022.
//

import UIKit

public class EmailVerificationViewController: OnboardingViewController {

    private var emailTextField: UnifyTextField = {
        let textField = UnifyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.please_enter_email, color: .darkGray, textAlignment: .center, isSecureTextEntry: false)
        return textField
    }()

    private var passwordTextField: UnifyTextField = {
        let textField = UnifyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: Unify.strings.please_enter_password, color: .darkGray, textAlignment: .center, isSecureTextEntry: false)
        return textField
    }()

    private let dontHaveAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Unify.strings.dont_have_an_account, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(navigateToCreateAccountScreen), for: .touchUpInside)
        return button
    }()

    @objc func navigateToCreateAccountScreen() {
        navigationController?.pushViewController(EmailSignUpViewController(viewModel: OnboardingViewModel()), animated: true)
    }

    let viewModel: OnboardingViewModel

    public override func continueButtonTapped() {
        if emailTextField.text?.isEmpty == true && passwordTextField.text?.isEmpty == true {
            self.presentAlert(title: Unify.strings.error, message: UnifyErrors.emailAndPasswordEmpty.rawValue, buttonTitle: Unify.strings.ok)
            return
        }

        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }

        if !isEmailValid(email) {
            self.presentAlert(title: Unify.strings.error, message: UnifyErrors.invalidEmail.rawValue, buttonTitle: Unify.strings.ok)
        }

        NetworkManager.shared.signInViaEmail(email: email, password: password) { success, error in
            print(success, error)
        }


//        if !isPasswordValid(password: password) {
//            self.presentAlert(title: Unify.strings.error, message: UnifyErrors.invalidPassword.rawValue, buttonTitle: Unify.strings.ok)
//        }

//        self.viewModel.signInWithEmail(email: email, password: password) { success, error in
//            if success {
//                self.navigationController?.pushViewController(HomeViewController(viewModel: HomeViewModel()), animated: true)
//                return
//            }
//
//            if error != nil {
//                self.setErrors(error: error?.localizedDescription ?? "")
//                return
//            }
//        }

    }

    required init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension EmailVerificationViewController {
    func setup() {

        title = Unify.strings.signin

        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(dontHaveAccountButton)

        setContraints()

        continueButton.configure(buttonText: Unify.strings.signin, textColor: .white, backgroundColors: .unifyBlue)
    }

    func setContraints() {
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72).isActive = true

        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true

        dontHaveAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        dontHaveAccountButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dontHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dontHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}
