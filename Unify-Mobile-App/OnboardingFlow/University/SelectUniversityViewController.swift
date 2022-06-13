//
//  SelectUniversityViewController.swift
//  Unify
//
//  Created by Melvin Asare on 04/10/2021.
//

import SearchTextField

class SelectUniversityViewController: OnboardingViewController {

    private let universitySearchField: UnifySearchTextField = {
        let textField = UnifySearchTextField()
        textField.configure(placeholder: Unify.strings.start_typing,
                            color: .gray,
                            textAlignment: .left)
        textField.textColor = .unifyGray
        return textField
    }()

    override func continueButtonTapped() {
        guard let university = universitySearchField.text else { return }
        if !university.isEmpty {
            viewModel.addUniversityToDatabase(universityName: university) { [weak self] success in
                if success == .completed {
                    self?.viewModel.saveOnboardingState(stringValue: "university", is_stage_complete: self?.convertEnumToString(state: .completed) ?? "uncomplete", isOnboardingComplete: false, userId: self?.viewModel.currentUserId ?? "no user id", completion: { success in
                        if success {
                            self?.navigationController?.pushViewController(SelectCourseViewController(viewModel: OnboardingViewModel()), animated: true)
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
    }
}

private extension SelectUniversityViewController {

     func setup() {
         title = Unify.strings.what_university_do_you_go_to
        view.addSubview(universitySearchField)

         universitySearchField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         universitySearchField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
         universitySearchField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72).isActive = true

        filterThroughUniversity(to: viewModel.university.wrappedValue, universityTextField: universitySearchField)
    }
}
