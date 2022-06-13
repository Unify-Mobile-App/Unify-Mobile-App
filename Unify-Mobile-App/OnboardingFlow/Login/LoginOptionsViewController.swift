//
//  LoginViewController.swift
//  Unify
//
//  Created by Melvin Asare on 27/09/2021.
//

import UIKit
import AuthenticationServices
import CryptoKit
import Firebase

final class LoginOptionsViewController: OnboardingViewController {

    public lazy var signInButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.login, textColor: .white, backgroundColors: .unifyBlue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return button
    }()

    public let dontHaveAnAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Unify.strings.dont_have_an_account, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(LoginOptionsViewController.self, action: #selector(goToTermsAndConditions), for: .touchUpInside)
        return button
    }()

    public lazy var signInWithAppleButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleAppleSignInTapped), for: .touchUpInside)
        return button
    }()

    public let seperator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .unifyBlue
        view.layer.cornerRadius = 8
        return view
    }()

    public let viewModel: OnboardingViewModel

    public let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Unify.strings.unify_logo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    public let termsAndConditionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Unify.strings.click_to_read_terms_of_service, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(LoginOptionsViewController.self, action: #selector(goToTermsAndConditions), for: .touchUpInside)
        return button
    }()

    @objc func signInButtonPressed() {
        self.navigationController?.pushViewController(EmailVerificationViewController(viewModel: OnboardingViewModel()), animated: true)
    }

    @objc func goToTermsAndConditions() {
        self.navigationController?.pushViewController(EmailVerificationViewController(viewModel: OnboardingViewModel()), animated: true)
    }

    @objc func handleAppleSignInTapped() {
        viewModel.signInWithApple()
    }

    public required init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    public override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        backButton.isHidden = true
    }
}

private extension LoginOptionsViewController {
    func setup() {
        subtitle = Unify.strings.different_students_different_unis_one_place

        continueButton.isHidden = true

        view.backgroundColor = .white
        view.addSubview(signInWithAppleButton)
        view.addSubview(signInButton)
        view.addSubview(logoImageView)
        view.addSubview(seperator)
        view.addSubview(termsAndConditionsButton)

        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive =  true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive =  true
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true

        seperator.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        seperator.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor).isActive = true
        seperator.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor).isActive = true

        signInWithAppleButton.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 10).isActive = true
        signInWithAppleButton.heightAnchor.constraint(equalTo: signInButton.heightAnchor).isActive = true
        signInWithAppleButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor).isActive = true
        signInWithAppleButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor).isActive = true

        termsAndConditionsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        termsAndConditionsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        termsAndConditionsButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor).isActive = true
        termsAndConditionsButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor).isActive = true
    }
}
