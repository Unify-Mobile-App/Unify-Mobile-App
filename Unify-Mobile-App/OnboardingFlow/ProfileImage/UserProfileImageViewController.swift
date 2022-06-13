//
//  UserProfileImageViewController.swift
//  Unify
//
//  Created by Melvin Asare on 04/10/2021.
//

import UIKit

class UserProfileImageViewController: OnboardingViewController {

    private lazy var avatarView: UIImageView = {
        let avatar = UIImageView()
        let tapAvatar = UITapGestureRecognizer(target: self, action: #selector(avatarPressed))
        avatar.addGestureRecognizer(tapAvatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isUserInteractionEnabled = true
        avatar.backgroundColor = .unifyBlue
        avatar.clipsToBounds = true
        return avatar
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

    private var imageHasBeenSelected: Bool = false {
        didSet {
            continueButton.isHidden = !imageHasBeenSelected
            guard imageHasBeenSelected else { return }
            subtitleLabel.text = Unify.strings.looking_good
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        avatarView.layer.cornerRadius = avatarView.frame.height / 2.0
    }

    private let viewModel: OnboardingViewModel

    override func continueButtonTapped() {
        viewModel.uploadImageToFirebaseStorage(avatarView: avatarView) { [weak self] success in
            if success == .completed {
                self?.viewModel.saveOnboardingState(stringValue: "profile_picture", is_stage_complete: self?.convertEnumToString(state: .completed) ?? "uncomplete", isOnboardingComplete: false, userId: self?.viewModel.currentUserId ?? "no user id", completion: { success in
                    if success {
                        self?.navigationController?.pushViewController(SelectUniversityViewController(viewModel: OnboardingViewModel()), animated: true)
                    }
                })
            }
        }
    }

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

extension UserProfileImageViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        avatarView.contentMode = .scaleAspectFill
        avatarView.image = chosenImage
        dismiss(animated: true, completion: nil)

        guard chosenImage.pngData() != nil else { return }
        imageHasBeenSelected = true
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @objc func avatarPressed() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }

    struct Constants {
        static let avatarDimension: CGFloat = 130
        static let unifyLogoWidth: CGFloat = 0.6
        static let unifyLogoHeight: CGFloat = 0.15
        static let gap: CGFloat = 20
        static let subtitleWidth: CGFloat = 0.9
        static let onboardingLogoHeight: CGFloat = 0.35
        static let buttonWidths: CGFloat = 0.85
        static let buttonHeights: CGFloat = 0.067
        static let footerButtonGap: CGFloat = 10
        static let footerButtonHeight: CGFloat = 0.05
    }
}

private extension UserProfileImageViewController {
    func setup() {
        title = Unify.strings.select_profile_picture

        view.addSubview(avatarView)
        avatarView.widthAnchor.constraint(equalToConstant: Constants.avatarDimension).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: Constants.avatarDimension).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
    }
}
