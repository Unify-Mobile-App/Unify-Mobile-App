//
//  EditProfileViewController.swift
//  Unify
//
//  Created by Melvin Asare on 06/02/2022.
//

import UIKit

class EditProfileViewController: UIViewController {

    // MARK: - Private

    private let headerView: EditProfileHeaderView = {
        let view = EditProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EditAvatarTableViewCell.self)
        tableView.register(EditNameTableViewCell.self)
        tableView.register(EditYearTableViewCell.self)
        tableView.register(EditCourseTableViewCell.self)
        tableView.register(EditUniversityTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()

    private let viewModel: EditProfileViewModel!

    // MARK: - View lifecycle

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

// MARK: - TableView DataSource & Delegate

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EditAvatarTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EditNameTableViewCell
            cell.configure(user: viewModel.user)
            cell.delegate = self
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EditUniversityTableViewCell
            cell.configure(user: viewModel.user)
            cell.delegate = self
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EditCourseTableViewCell
            cell.configure(user: viewModel.user)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EditYearTableViewCell
            cell.configure(user: viewModel.user)
            cell.delegate = self
            return cell
        }
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

private extension EditProfileViewController {
    func setup() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        view.addSubview(tableView)
        view.addSubview(headerView)

        headerView.delegate = self
        headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension EditProfileViewController: EditUsernameTableViewCellDelegate {
    func saveUsernameChanges(_ cell: EditNameTableViewCell, string: String?) {
        print("save pressed")
    }
}

extension EditProfileViewController: EditUniversityTableViewCellDelegate {
    func saveUniversityChanges(_ cell: EditUniversityTableViewCell, string: String?) {
        print("university pressed")
    }
}

extension EditProfileViewController: EditCourseTableViewCellDelegate {
    func saveCourseChanges(_ cell: EditCourseTableViewCell, string: String?) {
        print("course pressed")
    }
}

extension EditProfileViewController: EditYearTableViewCellDelegate {
    func saveYearChanges(_ cell: EditYearTableViewCell, string: String?) {
        print("year pressed")
    }
}
