//
//  PrivateInfrormationViewController.swift
//  Unify
//
//  Created by Melvin Asare on 04/10/2021.
//

import UIKit

class PrivateInfrormationViewController: OnboardingViewController {

    private let dateOfBirthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date of birth"
        textField.textColor = .darkGray
        textField.backgroundColor = .systemBlue
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        return picker
    }()

    private let genderTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Gender"
        textField.textColor = .darkGray
        textField.backgroundColor = .systemBlue
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let nationalityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nationality"
        textField.textColor = .darkGray
        textField.backgroundColor = .systemBlue
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Unify.strings.profile_picture
        label.font = UIFont(name: "Arial", size: 25)
        label.textColor = .unifyGray
        return label
    }()

    private let viewModel: OnboardingViewModel

    override func continueButtonTapped() {
        guard
            let dateOfBirth = dateOfBirthTextField.text,
            let gender = genderTextField.text,
            let nationality = nationalityTextField.text
        else { return }

        if dateOfBirth.isEmpty || gender.isEmpty || nationality.isEmpty {

        } else {
            viewModel.addPrivateDataToDatabase(dob: dateOfBirth, gender: gender, nationality: nationality) { [weak self] success in
                if success == .completed {
                    self?.navigationController?.pushViewController(HomeViewController(viewModel: HomeViewModel()), animated: true)
                    self?.viewModel.saveOnboardingState(stringValue: "private_data", is_stage_complete: self?.convertEnumToString(state: .completed) ?? "uncomplete", isOnboardingComplete: true , userId: self?.viewModel.currentUserId ?? "NO USER ID", completion: { _ in
                        self?.navigationController?.pushViewController(HomeViewController(viewModel: HomeViewModel()), animated: true)
                    })
                }
            }
        }
    }

//    override func skipButtonTapped() {
//        self.viewModel.saveOnboardingState(stringValue: "private_data", is_stage_complete: self.convertEnumToString(state: .uncomplete), isOnboardingComplete: true ,userId: self.viewModel.currentUserId ?? "NO USER ID") { _ in
//            self.navigationController?.pushViewController(HomeViewController(viewModel: HomeViewModel()), animated: true)
//        }
//    }

    required init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func showDatePicker() {
        datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.locale = .current
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
    }

    @objc func handleDateSelection() {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(dateOfBirthTextField)
        view.addSubview(genderTextField)
        view.addSubview(nationalityTextField)
        view.addSubview(datePicker)

        datePicker.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        datePicker.datePickerMode = .date

        dateOfBirthTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        dateOfBirthTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        genderTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        genderTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        nationalityTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        nationalityTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        continueButton.isHidden = false
        navigationController?.isNavigationBarHidden = false

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        showDatePicker()
    }
}
