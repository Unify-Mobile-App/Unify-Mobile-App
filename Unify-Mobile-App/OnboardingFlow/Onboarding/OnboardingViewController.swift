//
//  OnboardingViewController.swift
//  Unify
//
//  Created by Melvin Asare on 04/10/2021.
//

import UIKit

public class OnboardingViewController: UIViewController {

    public override var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    public var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    public lazy var continueButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.continue_text, textColor: .white, backgroundColors: .unifyBlue)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Times New Roman", size: 28)
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()

    public lazy var backButton: UIButton = {
        let button = UIButton()
        if #available(iOS 15.0, *) {
            let configuration = UIImage.SymbolConfiguration(hierarchicalColor: .black)
            button.setImage(UIImage(systemName: "chevron.backward", withConfiguration: configuration), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        return button
    }()

    public lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Unify.strings.skip), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 20)
        label.textColor = .black
        return label
    }()

    @objc public func exitButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    @objc public func skipButtonPressed() {}
    @objc public func continueButtonTapped() {}

    private let viewModel: OnboardingViewModel

    required init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension OnboardingViewController {
    func setup() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(continueButton)
        view.addSubview(skipButton)
        view.addSubview(backButton)

        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor, constant: 20).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true

        skipButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true

        backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true

        skipButton.isHidden = true
    }
}
