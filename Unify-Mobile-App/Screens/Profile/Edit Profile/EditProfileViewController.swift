//
//  EditProfileViewController.swift
//  Unify
//
//  Created by Melvin Asare on 06/02/2022.
//

import UIKit

class EditProfileViewController: UIViewController {

    private let cancelEditingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(.unifyGray, for: .normal)
        button.addTarget(self, action: #selector(cancelEditPressed), for: .touchUpInside)
        return button
    }()

    private lazy var saveButton: UnifyButton = {
        let button = UnifyButton()
        button.configure(buttonText: Unify.strings.save, textColor: .white, backgroundColors: .unifyBlue)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()

    @objc func cancelEditPressed() {
        dismiss(animated: true, completion: nil)
    }

    @objc func saveButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

private extension EditProfileViewController {
    func setup() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        view.addSubview(cancelEditingButton)
        view.addSubview(saveButton)

        cancelEditingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        cancelEditingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cancelEditingButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        cancelEditingButton.widthAnchor.constraint(equalToConstant: 35).isActive = true

        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
