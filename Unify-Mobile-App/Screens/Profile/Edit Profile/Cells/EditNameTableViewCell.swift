//
//  EditNameTableViewCell.swift
//  Unify-Mobile-App
//
//  Created by Melvin Asare on 27/06/2022.
//

import UIKit

protocol EditUsernameTableViewCellDelegate: AnyObject {
    func saveUsernameChanges(_ cell: EditNameTableViewCell, string: String?)
}

class EditNameTableViewCell: UITableViewCell {

    public weak var delegate: EditUsernameTableViewCellDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Unify.strings.name
        label.sizeToFit()
        
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(usernameDidUpdate), for: .editingChanged)
        textField.addTarget(self, action: #selector(usernameDidUpdate), for: .editingDidBegin)
        return textField
    }()

    @objc func usernameDidUpdate() {
        delegate?.saveUsernameChanges(self, string: nameTextField.text)
    }

    private let underline: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .unifyGray
        return view
    }()

    func configure(user: User) {
        nameTextField.text = user.name
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension EditNameTableViewCell {

    func setup() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(underline)

        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true

        nameTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        underline.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5).isActive = true
        underline.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 6).isActive = true
        underline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 6).isActive = true
        underline.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
}


