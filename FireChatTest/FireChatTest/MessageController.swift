//
//  MessageController.swift
//  SimpleChatFirebaseTest
//
//  Created by Jake Hardy on 4/11/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation

class MessageController {
    
    static func createMessage(senderID: String,threadID: String, bodyText: String, username: String, completion: (success: Bool) -> Void) {
        
        var message = Message(senderID: senderID, threadID: threadID, username: username, messageBodyText: bodyText, identifier: nil)
        message.save()
        
        completion(success: true)
    }
    
    static func observeMessagesForThread(threadIdentifier: String, completion: (message: Message) -> Void) {
        FirebaseController.observeChildAtEndPoint("\(messageEndPoint)/\(threadIdentifier)", completion: { (data) in
            guard let data = data as? [String : AnyObject] else { return }
            print(data)
            
            guard let identifier = data[IDENTIFIER_KEY] as? String else { return  }
            guard let message = Message(json: data, identifier: identifier) else { return }
            
            completion(message: message)
            
        })
    }
}