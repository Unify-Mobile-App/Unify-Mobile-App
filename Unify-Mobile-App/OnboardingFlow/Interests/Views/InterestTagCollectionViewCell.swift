//
//  InterestTagCollectionViewCell.swift
//  Unify
//
//  Created by Melvin Asare on 06/10/2021.
//

import UIKit

class InterestTagCollectionViewCell: UICollectionViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        return view
    }()

    public let tagsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.font = Consts.iconFont
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.bounds.height / 2.0
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    struct Consts {
        static let bubblePadding: CGFloat = 13
        static let iconFont: UIFont = UIFont(name: "Arial", size: 25)!
    }
}

extension InterestTagCollectionViewCell {

    func setup() {
        self.addSubview(containerView)
        containerView.addSubview(tagsTitleLabel)

        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        tagsTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        tagsTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
}
