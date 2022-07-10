//
//  EditProfileTableViewCell.swift
//  Unify-Mobile-App
//
//  Created by Melvin Asare on 27/06/2022.
//

import UIKit
import SDWebImage

class EditAvatarTableViewCell: UITableViewCell {

    private lazy var profileImageView: AvatarView = {
        let imageView = AvatarView(image: UIImage(named: "solidblue"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    func configure(user: User) {
        if !user.profile_picture_url.isEmpty {
            profileImageView.sd_setImage(with: URL(string: user.profile_picture_url, relativeTo: nil))
        } 
    }

    override func layoutSubviews() {
        profileImageView.layer.cornerRadius =  profileImageView.frame.height / 2.0
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension EditAvatarTableViewCell {
    func setup() {
        contentView.addSubview(profileImageView)

        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
}
