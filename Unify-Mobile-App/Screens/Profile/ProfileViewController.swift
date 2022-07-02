//
//  ProfileViewController.swift
//  Unify
//
//  Created by Melvin Asare on 07/10/2021.
//

import Floaty
import SDWebImage
import Foundation

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModel
    private let defaults = UserDefaults.standard
    
    private lazy var profileImageView: AvatarView = {
        let imageView = AvatarView(image: UIImage(named: "solidblue"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var usernameLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 22, titleText: viewModel.user.name)
        return label
    }()
    
    private lazy var universityLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 22, titleText: viewModel.user.university_name)
        return label
    }()
    
    private lazy var yearOfStudyLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.user.studyYear.year
        label.configure(textAlignment: .center, fontSize: 22, titleText: viewModel.user.studyYear.year)
        return label
    }()
    
    private lazy var courseLabel: UnifyTitleLabel = {
        let label = UnifyTitleLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(textAlignment: .center, fontSize: 22, titleText: viewModel.user.course.name)
        return label
    }()
    
    private lazy var optionsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal         )
        button.setTitleColor(.unifyGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(optionsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let interestsLabel: UILabel = {
        let label = UILabel()
        label.text = "Show interests here"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var interestsCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    @objc func optionsButtonPressed() {
        let alertController = UIAlertController(title: nil, message: Unify.strings.please_select_option, preferredStyle: .actionSheet)
        guard let currentUserId = viewModel.currentUser?.uid else { return }
        
        if self.isCurrentUser(currentUserId: currentUserId, userId: viewModel.user.uid) == false {
            let actionOne = UIAlertAction(title: Unify.strings.message, style: .default) { [weak self] action  in
           //     self?.navigationController?.pushViewController(ChatViewController(viewModel: ChatLogViewModel(user2UID: self?.viewModel.user.uid)), animated: true)
            }

            let actionTwo = UIAlertAction(title: Unify.strings.add, style: .default) { action in }
            let actionThree = UIAlertAction(title: Unify.strings.block, style: .destructive) { action in }
            let actionFour = UIAlertAction(title: Unify.strings.cancel, style: .cancel) { action in }

            alertController.addAction(actionOne)
            alertController.addAction(actionTwo)
            alertController.addAction(actionThree)
            alertController.addAction(actionFour)

            present(alertController, animated: true, completion: nil)
        } else {
            let actionOne = UIAlertAction(title: Unify.strings.edit_profile, style: .default) { [weak self] action  in
                self?.navigationController?.pushViewController(EditProfileViewController(viewModel: EditProfileViewModel(user: self?.viewModel.user ?? Unify.defaultUser)), animated: true)
            }

            let actionTwo = UIAlertAction(title: Unify.strings.settings, style: .default) { action in }
            let actionThree = UIAlertAction(title: Unify.strings.log_out, style: .destructive) { action in self.signOut() }
            let actionFour = UIAlertAction(title: Unify.strings.cancel, style: .cancel) { action in }

            alertController.addAction(actionOne)
            alertController.addAction(actionTwo)
            alertController.addAction(actionThree)
            alertController.addAction(actionFour)

            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func configureProfileView() {
        if viewModel.user.profile_picture_url.isEmpty {
            profileImageView.backgroundColor = .unifyBlue
        } else {
            profileImageView.sd_setImage(with: URL(string: viewModel.user.profile_picture_url, relativeTo: nil))
        }
    }

    struct Consts {
        static let floatingButtonWidth: CGFloat = 52.0
        static let floatingButtonPadding: CGFloat = 28.0
    }
    
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
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ProfileViewController: FloatyDelegate {
    
    @objc func returnToHome() {
//        let viewModel = HomeViewModel()
//        let viewController = HomeViewController(viewModel: viewModel)
//        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func returnToMessages() {
     //   let viewController = MessageFeedViewController()
    //    navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func returnToProfile() {
        self.dismiss(animated: true)
    }
    
    @objc func appLogOut() {
        signOut()
    }
}

extension ProfileViewController {
    func setup() {
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: true)
        configureProfileView()

        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(courseLabel)
        view.addSubview(universityLabel)
        view.addSubview(yearOfStudyLabel)
        view.addSubview(optionsButton)
        view.addSubview(floatingActionButton)
        view.addSubview(interestsLabel)

        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50).isActive = true

        universityLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        universityLabel.centerXAnchor.constraint(equalTo: usernameLabel.centerXAnchor).isActive = true
        universityLabel.leadingAnchor.constraint(equalTo: courseLabel.leadingAnchor).isActive = true
        universityLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        courseLabel.topAnchor.constraint(equalTo: universityLabel.bottomAnchor, constant: 10).isActive = true
        courseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        courseLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        yearOfStudyLabel.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: 10).isActive = true
        yearOfStudyLabel.leadingAnchor.constraint(equalTo: courseLabel.leadingAnchor).isActive = true
        yearOfStudyLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        setFloatyConstraints(view: self.view, button: floatingActionButton)

        optionsButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
            optionsButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
            optionsButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
            optionsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        interestsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        interestsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
