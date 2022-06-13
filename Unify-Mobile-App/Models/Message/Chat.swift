//
//  Chat.swift
//  Unify
//
//  Created by Melvin Asare on 13/11/2021.
//

import Foundation

struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
        return ["users": users]
    }
}

extension Chat {
    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
}
