//
//  UsersViewModel.swift
//  Unify
//
//  Created by Melvin Asare on 03/11/2021.
//

import Foundation

class UsersViewModel {

    public var users: [User]?

    init(users: [User]?) {
        self.users = users
    }

    func user(for indexPath: IndexPath) -> User? {
        return users?.object(at: indexPath.row)
    }
}
