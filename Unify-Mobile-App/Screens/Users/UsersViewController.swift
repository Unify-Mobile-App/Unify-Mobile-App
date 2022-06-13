//
//  UsersViewController.swift
//  Unify
//
//  Created by Melvin Asare on 03/11/2021.
//

import UIKit
import Floaty

class UsersViewController: UIViewController {

    private let viewModel: UsersViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var floatingActionButton: Floaty = {
        let view = Floaty()
        Floaty.global.rtlMode = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fabDelegate = self
        view.overlayColor = .clear
        view.openAnimationType = .slideUp
        view.size = Consts.floatingButtonWidth
        view.buttonColor = .unifyBlue
        view.plusColor = .white
        view.paddingX = Consts.floatingButtonPadding
        view.paddingY = Consts.floatingButtonPadding
        view.relativeToSafeArea = true
        view.itemSpace = 18.0
        view.addUnifyAction(title: Unify.strings.sign_out, color: .unifyBlue) { [weak self] in self?.appLogOut() }
        view.addUnifyAction(title: Unify.strings.profile, color: .unifyBlue) { [weak self] in self?.returnToProfile() }
        view.addUnifyAction(title: Unify.strings.messages, color: .unifyBlue) { [weak self] in self?.returnToMessages() }
        view.addUnifyAction(title: Unify.strings.home, color: .unifyBlue) { [weak self] in self?.returnToHome() }
        return view
    }()

    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        view.addSubview(tableView)
        tableView.constrain(to: self.view)
        view.addSubview(floatingActionButton)
        setFloatyConstraints(view: self.view, button: floatingActionButton)
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = viewModel.users?[indexPath.row] else { return }
        navigationController?.pushViewController(ProfileViewController(viewModel: ProfileViewModel(user: user)), animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Unify.strings.cell, for: indexPath) as! UsersTableViewCell

        if let user = viewModel.user(for: indexPath) {
            cell.configure(with: user)
        }
        return cell
    }
}

extension UsersViewController: FloatyDelegate {

    @objc func returnToHome() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func returnToMessages() {
//        let viewController = MessageFeedViewController()
//        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func returnToProfile() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func appLogOut() {
        signOut()
    }
}
