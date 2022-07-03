//
//  EditYearTableViewCell.swift
//  Unify-Mobile-App
//
//  Created by Melvin Asare on 27/06/2022.
//

import UIKit

protocol EditYearTableViewCellDelegate: AnyObject {
    func saveYearChanges(_ cell: EditYearTableViewCell, string: String?)
}

class EditYearTableViewCell: UITableViewCell {

    public weak var delegate: EditYearTableViewCellDelegate?

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Unify.strings.year
        return label
    }()

    private let yearTextField: UITextField = {
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
        yearTextField.text = user.studyYear.year
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension EditYearTableViewCell {

    func setup() {
        contentView.addSubview(yearLabel)
        contentView.addSubview(yearTextField)
        contentView.addSubview(underline)

        yearLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        yearLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true

        yearTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        yearTextField.leadingAnchor.constraint(equalTo:  yearLabel.trailingAnchor).isActive = true
        yearTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        underline.topAnchor.constraint(equalTo: yearTextField.bottomAnchor, constant: 5).isActive = true
        underline.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor, constant: 6).isActive = true
        underline.trailingAnchor.constraint(equalTo: yearTextField.leadingAnchor).isActive = true
        underline.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
}
