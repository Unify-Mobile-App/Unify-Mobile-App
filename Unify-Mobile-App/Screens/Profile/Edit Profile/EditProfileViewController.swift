//
//  EditProfileViewController.swift
//  Unify
//
//  Created by Melvin Asare on 06/02/2022.
//

import UIKit

class EditProfileViewController: UIViewController {

    // MARK: - Private

    private let header: EditProfileHeaderView = {
        let view = EditProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EditAvatarTableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        tableView.register(EditNameTableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        tableView.register(EditYearTableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        tableView.register(EditCourseTableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        tableView.register(EditUniversityTableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .red
        tableView.keyboardDismissMode = .interactive
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()

    private let viewModel: EditProfileViewModel!

    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

private extension EditProfileViewController {
    func setup() {
        view.backgroundColor = .white

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section

        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EditNameTableViewCell
            cell?.configure(user: viewModel.user)
        } else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EditUniversityTableViewCell
            cell?.configure(user: viewModel.user)
            return cell ?? UITableViewCell()
        } else if section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EditCourseTableViewCell
            cell?.configure(user: viewModel.user)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EditYearTableViewCell
            cell?.configure(user: viewModel.user)
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
}

extension EditProfileViewController: EditProfileHeaderViewDelegate {
    func saveEditChanges(_ headerView: EditProfileHeaderView) {
        viewModel.saveUserProfile()
    }

    func didCancelEditChanges(_ headerView: EditProfileHeaderView) {
        dismiss(animated: true, completion: nil)
    }
}
