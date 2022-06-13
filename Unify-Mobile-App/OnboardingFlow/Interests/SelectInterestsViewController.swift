//
//  SelectInterestsViewController.swift
//  Unify
//
//  Created by Melvin Asare on 04/10/2021.
//

import UIKit

class SelectInterestsViewController: OnboardingViewController {
    private let viewModel: OnboardingViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    required init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func continueButtonTapped() {
        viewModel.addInterestsToDatabase(interests: viewModel.usersSelectedInterestArray) { [weak self] success in
            if success == .completed {
                self?.viewModel.saveOnboardingState(stringValue: "selected_interest", is_stage_complete: self?.convertEnumToString(state: .completed) ?? "uncomplete", isOnboardingComplete: true, userId: self?.viewModel.currentUserId ?? "NO USER ID", completion: { success in
                    self?.navigationController?.pushViewController(PrivateInfrormationViewController(viewModel: OnboardingViewModel()), animated: true)
                })
            }
        }
    }

//    override func skipButtonTapped() {
//        viewModel.saveOnboardingState(stringValue: "selected_interest", is_stage_complete: self.convertEnumToString(state: .uncomplete), isOnboardingComplete: true, userId: viewModel.currentUserId ?? "NO USER ID") { _ in
//            self.navigationController?.pushViewController(PrivateInfrormationViewController(viewModel: OnboardingViewModel()), animated: true)
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)

        continueButton.isHidden = true
        continueButton.bringSubviewToFront(self.view)
        tableView.constrain(to: self.view)

        let continueButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(continueButtonTapped))
        navigationItem.rightBarButtonItem = continueButton
    }
}

extension SelectInterestsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.interestsData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Unify.strings.cell, for: indexPath)
        if let name = viewModel.interestMapped(for: indexPath) {
            cell.textLabel?.text = name
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appendedInterests = viewModel.interestsData[indexPath.row].name
        viewModel.usersSelectedInterestArray.append(appendedInterests)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let appendedInterests = viewModel.interestsData[indexPath.row].name
        let filteredArray = viewModel.usersSelectedInterestArray.filter { $0 != appendedInterests }
    }
}
