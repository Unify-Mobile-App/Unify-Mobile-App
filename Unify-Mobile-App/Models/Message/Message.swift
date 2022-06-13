//
//  Message.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 08/06/2021.
//

import Firebase
import MessageKit

struct Message {
    // I want to also save OtherUserId, latestMessage and created.
    var id: String
    var content: String
    var created: Timestamp
    var senderID: String
    var senderName: String
  //  var latestMessage: LatestMessage
    var dictionary: [String: Any] {
        return [
            "id": id,
            "content": content,
            //  "created": created,
            "senderID": senderID,
            "senderName":senderName,
         //   "latestMessage": latestMessage
        ]
    }
}

extension Message {
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let content = dictionary["content"] as? String,
              let created = dictionary["created"] as? Timestamp,
              let senderID = dictionary["senderID"] as? String,
              let senderName = dictionary["senderName"] as? String
//              let latestMessage = dictionary["latestMessage"] as? LatestMessage
        else {return nil}
        self.init(id: id, content: content, created: created, senderID: senderID, senderName: senderName)
    }
}

extension Message: MessageType {
    var sender: SenderType {
        return ChatUser(senderId: senderID, displayName: senderName)
    }
    var messageId: String {
        return id
    }
    var sentDate: Date {
        return created.dateValue()
    }
    var kind: MessageKind {
        return .text(content)
    }
}
