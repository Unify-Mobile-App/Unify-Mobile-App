//
//  ViewController.swift
//  Unify
//
//  Created by Melvin Asare on 24/09/2021.
//

import UIKit
import Floaty

class HomeViewController: UIViewController {

    private let viewModel: HomeViewModel!

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search University Name"
        return searchBar
    }()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        navigationItem.titleView = searchBar
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Unify.strings.cell)
        tableView.constrain(to: self.view)
        searchBar.delegate = self
        view.addSubview(floatingActionButton)
        setFloatyConstraints(view: self.view, button: floatingActionButton)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.isNavigationBarHidden = false        
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Unify.strings.cell, for: indexPath)
        let sortedNames = viewModel.filteredUniversityData.sorted()
        cell.textLabel?.text = sortedNames[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredUniversityData.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if let cellText = cell.textLabel?.text {
            let filteredUsers = viewModel.retrieveUsersFromUniversity(uni: cellText)
            navigationController?.pushViewController(UsersViewController(viewModel: UsersViewModel(users: filteredUsers)), animated: true)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredUniversityData = []

        if searchText.isEmpty {
            viewModel.filteredUniversityData = viewModel.universityObservable.wrappedValue
        } else {
            for uni in viewModel.universityObservable.wrappedValue {
                if uni.lowercased().contains(searchText.lowercased()) {
                    viewModel.filteredUniversityData.append(uni)
                }
            }
        }
        self.tableView.reloadData()
    }
}

extension HomeViewController: FloatyDelegate {

    @objc func returnToHome() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func returnToMessages() {
     //   let viewController = MessageFeedViewController()
      //  navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func returnToProfile() {
        let viewModel = ProfileViewModel(user: self.viewModel.user.wrappedValue ?? Unify.defaultUser)
        let viewController = ProfileViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func appLogOut() {
        signOut()
    }
}
