//
//  EditUniversityTableViewCell.swift
//  Unify-Mobile-App
//
//  Created by Melvin Asare on 27/06/2022.
//

import UIKit

class EditUniversityTableViewCell: UITableViewCell {

    private let universityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Unify.strings.university
        return label
    }()

    private let universityTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let underline: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .unifyGray
        return view
    }()

    func configure(user: User) {
        universityTextField.text = user.university_name
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension EditUniversityTableViewCell {

    func setup() {
        contentView.addSubview(universityLabel)
        contentView.addSubview(universityTextField)
        contentView.addSubview(underline)

        universityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        universityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true

        universityTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        universityTextField.leadingAnchor.constraint(equalTo: universityLabel.trailingAnchor).isActive = true
        universityTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        underline.topAnchor.constraint(equalTo: universityTextField.bottomAnchor, constant: 5).isActive = true
        underline.leadingAnchor.constraint(equalTo: universityTextField.leadingAnchor).isActive = true
        underline.trailingAnchor.constraint(equalTo: universityTextField.trailingAnchor).isActive = true
        underline.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
}


