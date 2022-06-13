//
//  SelectCourseViewController.swift
//  Unify
//
//  Created by Melvin Asare on 04/10/2021.
//

import UIKit

class SelectCourseViewController: OnboardingViewController {

    private let courseSearchField: UnifySearchTextField = {
        let textField = UnifySearchTextField()
        textField.configure(placeholder: Unify.strings.start_typing,
                            color: .gray,
                            textAlignment: .left)
        textField.textColor = .unifyGray
        return textField
    }()

    override func continueButtonTapped() {
        guard let course = courseSearchField.text else { return }
        if !course.isEmpty {
            viewModel.addCourseToDatabase(courseName: course) { [weak self] success in
                if success == .completed {
                    self?.viewModel.saveOnboardingState(stringValue: "course", is_stage_complete: self?.convertEnumToString(state: .completed) ?? "uncomplete", isOnboardingComplete: false, userId: self?.viewModel.currentUserId! ?? "failed no user", completion: { success in
                        if success {
                            self?.navigationController?.pushViewController(SelectYearViewController(viewModel: OnboardingViewModel()), animated: true)
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

private extension SelectCourseViewController {

    func setup() {
        title = Unify.strings.what_are_you_studying
        
        view.addSubview(courseSearchField)

        courseSearchField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        courseSearchField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        courseSearchField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72).isActive = true

        filterThroughCourses(to: viewModel.course, courseTextField: courseSearchField)
    }
}
