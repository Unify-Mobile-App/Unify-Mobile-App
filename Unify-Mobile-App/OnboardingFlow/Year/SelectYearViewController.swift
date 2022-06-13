//
//  SelectYearViewController.swift
//  Unify
//
//  Created by Melvin Asare on 04/10/2021.
//

import UIKit

class SelectYearViewController: OnboardingViewController {

    private let yearSearchField: UnifySearchTextField = {
        let textField = UnifySearchTextField()
        textField.configure(placeholder: Unify.strings.start_typing,
                            color: .gray,
                            textAlignment: .left)
        textField.textColor = .unifyGray
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

    override func continueButtonTapped() {
        guard let year = yearSearchField.text else { return }

        if !year.isEmpty {
            viewModel.addYearToDatabase(year: year) { [weak self] success in
                if success == .completed {
                    self?.viewModel.saveOnboardingState(stringValue: "year", is_stage_complete: self?.convertEnumToString(state: .completed) ?? "uncomplete", isOnboardingComplete: false, userId: self?.viewModel.currentUserId! ?? "failed no user", completion: { success in
                        if success {
                            self?.navigationController?.pushViewController(HomeViewController(viewModel: HomeViewModel()), animated: true)
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
        setup()
        // Do any additional setup after loading the view.
    }
}

private extension SelectYearViewController {

    func setup() {
        title = Unify.strings.what_year_are_you_in
        view.addSubview(yearSearchField)

        yearSearchField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yearSearchField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        yearSearchField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72).isActive = true

        filterThroughYear(to: viewModel.year, studyYearTextField: yearSearchField)
    }
}
