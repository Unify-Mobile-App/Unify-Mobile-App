//
//  UsersTableViewCell.swift
//  Unify
//
//  Created by Melvin Asare on 03/11/2021.
//

import UIKit
import SDWebImage

class UsersTableViewCell: UITableViewCell {

    private let profileImageView: AvatarView = {
        let imageView = AvatarView(image: UIImage(named: "solidblue"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    private let yearOfStudyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Year 1"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    private let courseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2.0
    }

    func configure(with user: User) {
        if user.profile_picture_url.isEmpty {
            profileImageView.backgroundColor = .unifyBlue
        } else {
            profileImageView.sd_setImage(with: URL(string: user.profile_picture_url, relativeTo: nil))
        }

        usernameLabel.text = user.name
        yearOfStudyLabel.text = user.studyYear.year
        courseLabel.text = user.course.name
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension UsersTableViewCell {

    func setup() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(courseLabel)
        contentView.addSubview(yearOfStudyLabel)

        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true

        usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -25).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        courseLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8).isActive = true
        courseLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive = true
        courseLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor).isActive = true

        yearOfStudyLabel.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: 8).isActive = true
        yearOfStudyLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20).isActive = true
    }
}
