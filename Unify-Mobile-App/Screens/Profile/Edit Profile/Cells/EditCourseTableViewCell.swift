//
//  EditCourseTableViewCell.swift
//  Unify-Mobile-App
//
//  Created by Melvin Asare on 27/06/2022.
//

import UIKit

class EditCourseTableViewCell: UITableViewCell {

    private let courseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Unify.strings.course
        return label
    }()

    private let courseTextField: UITextField = {
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
        courseTextField.text = user.course.name
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension EditCourseTableViewCell {

    func setup() {
        contentView.addSubview(courseLabel)
        contentView.addSubview(courseTextField)
        contentView.addSubview(underline)

        courseLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        courseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true

        courseTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        courseTextField.leadingAnchor.constraint(equalTo: courseLabel.trailingAnchor).isActive = true
        courseTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        underline.topAnchor.constraint(equalTo: courseTextField.bottomAnchor, constant: 5).isActive = true
        underline.leadingAnchor.constraint(equalTo: courseTextField.leadingAnchor).isActive = true
        underline.trailingAnchor.constraint(equalTo: courseTextField.trailingAnchor).isActive = true
        underline.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
}
