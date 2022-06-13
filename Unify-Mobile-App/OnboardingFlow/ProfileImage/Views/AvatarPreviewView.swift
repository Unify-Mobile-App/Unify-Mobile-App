//
//  AvatarPreviewView.swift
//  Unify
//
//  Created by Melvin Asare on 07/10/2021.
//


import UIKit

class AvatarPreviewView: UIView {

    private let avatarOutlineView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "avatar_outline")
        return imageView
    }()

    private let backgroundView: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "upload_image_background"), for: .normal)
        button.tintColor = .unifyGray
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarOutlineView.layer.cornerRadius = avatarOutlineView.frame.height / 2.0
    }

    public func setImage(_ image: UIImage?) {
        avatarOutlineView.image = image
    }

    struct Consts {
        static let externalViewDimension: CGFloat = 120
        static let internalViewDimension: CGFloat = 80
    }
}

private extension AvatarPreviewView {

    func setup() {
        addSubview(backgroundView)
        addSubview(avatarOutlineView)

        backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: Consts.externalViewDimension).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: Consts.externalViewDimension).isActive = true

        avatarOutlineView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        avatarOutlineView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        avatarOutlineView.widthAnchor.constraint(equalToConstant: Consts.internalViewDimension).isActive = true
        avatarOutlineView.heightAnchor.constraint(equalToConstant: Consts.internalViewDimension).isActive = true
    }
}

