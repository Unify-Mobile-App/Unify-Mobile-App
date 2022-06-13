//
//  UnifyButton.swift
//  Unify-iOSUITests
//
//  Created by Melvin Asare on 01/03/2021.
//

import UIKit

public class UnifyButton: UIButton {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    func configure(buttonText: String, textColor: UIColor, backgroundColors: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.textAlignment = .center
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        setTitle(buttonText, for: .normal)
        backgroundColor = backgroundColors
        layer.cornerRadius = 20
        layer.borderWidth = 2
    }

    func addImage(image: UIImage) {
        iconImageView.image = image

        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension UnifyButton {
    func setup() {
        addSubview(iconImageView)
        topAnchor.constraint(equalTo: topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}
