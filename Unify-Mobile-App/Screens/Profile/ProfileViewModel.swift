//  ProfileViewModel.swift
//  File.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 06/03/2021.
//

import Foundation

class ProfileViewModel {

    public var user: User
    public let currentUser = AccountManager.account.currentUser


    func updateProfileInformation() {
        
    }

    init(user: User) {
        self.user = user

        print(user.uid, currentUser?.uid)
    }
}
