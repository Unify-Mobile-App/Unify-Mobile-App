//
//  EmailSignUpViewController.swift
//  Unify
//
//  Created by Melvin Asare on 03/03/2022.
//

import UIKit

class EmailSignUpViewController: OnboardingViewController {

    private var emailTextField: UnifyTextField = {
        let textField = UnifyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: "Please Enter Email", color: .darkGray, textAlignment: .center, isSecureTextEntry: false)
        return textField
    }()

    private var passwordTextField: UnifyTextField = {
        let textField = UnifyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.configure(placeholder: "Please Enter Password", color: .darkGray, textAlignment: .center, isSecureTextEntry: false)
        return textField
    }()

    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Already have an account? Sign up here", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        return button
    }()

    public let viewModel: OnboardingViewModel

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
            return
        }

        if !isPasswordValid(password: password) {
            self.presentAlert(title: Unify.strings.error, message: UnifyErrors.invalidPassword.rawValue, buttonTitle: Unify.strings.ok)
            return
        }

        self.viewModel.createAccountWithEmail(email: email, password: password) { success, error  in
            if success {
                self.navigationController?.pushViewController(CreateUsernameViewController(viewModel: OnboardingViewModel()), animated: true)
            }
            
            if error != nil {
                self.setErrors(error: error?.localizedDescription ?? "" )
                return
            }
        }
    }

    public required init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension EmailSignUpViewController {
    func setup() {
        title = Unify.strings.create_account

        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(alreadyHaveAccountButton)

        setContraints()

        continueButton.configure(buttonText: Unify.strings.create_account, textColor: .white, backgroundColors: .unifyBlue)
    }

    func setContraints() {
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72).isActive = true

        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true

        alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        alreadyHaveAccountButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        alreadyHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        alreadyHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}
