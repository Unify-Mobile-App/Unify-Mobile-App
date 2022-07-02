//
//  EditProfileHeader.swift
//  Unify-Mobile-App
//
//  Created by Melvin Asare on 02/07/2022.
//

import UIKit

protocol EditProfileHeaderViewDelegate: AnyObject {
    func didCancelEditChanges(_ headerView: EditProfileHeaderView)
    func saveEditChanges(_ headerView: EditProfileHeaderView)
}

class EditProfileHeaderView: UIView {

    // MARK: - Delegate

    public weak var delegate: EditProfileHeaderViewDelegate?

    // MARK: - Private

    private let editProfileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Unify.strings.edit_profile
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Unify.strings.save, for: .normal)
        button.setTitleColor(.unifyGray, for: .normal)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Unify.strings.cancel, for: .normal)
        button.setTitleColor(.unifyGray, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()


    // MARK: - Functions

    @objc func saveButtonPressed() {
        delegate?.saveEditChanges(self)
    }

    @objc func cancelButtonPressed() {
        delegate?.didCancelEditChanges(self)
    }


    // MARK: - View Lifecycle

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("EditProfileHeader Crashed")
    }
}

// MARK: - Setup View

extension EditProfileHeaderView {

    func setup() {
        addSubview(stackView)

        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(editProfileLabel)
        stackView.addArrangedSubview(saveButton)

        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
