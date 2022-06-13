//
//  Sender.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/06/2021.
//

import MessageKit

struct ChatUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
