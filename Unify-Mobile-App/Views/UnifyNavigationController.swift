//
//  UnifyNavigationController.swift
//  Unify
//
//  Created by Melvin Asare on 24/12/2021.
//

import UIKit

class UnifyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            // disable dark/light mode changes for now
            overrideUserInterfaceStyle = .light

            let navBarAppearance = UINavigationBarAppearance()
        //    navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                                         .font: UIFont.systemFont(ofSize: 32, weight: .bold)]
            navBarAppearance.backgroundColor = .white
            navBarAppearance.shadowColor = .clear

            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            UINavigationBar.appearance().barTintColor = .white
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        }
        navigationBar.prefersLargeTitles = false
        navigationBar.isTranslucent = false
        extendedLayoutIncludesOpaqueBars = true
    }
}
