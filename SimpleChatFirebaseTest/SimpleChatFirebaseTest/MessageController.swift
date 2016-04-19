//
//  MessageController.swift
//  SimpleChatFirebaseTest
//
//  Created by Jake Hardy on 4/11/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation

class MessageController {
    
    static func createMessage(threadID: String, bodyText: String, username: String, completion: (message: Message) -> Void) {
        
        var message = Message(threadID: threadID, username: username, messageBodyText: bodyText, identifier: nil)
        message.save()
        
        completion(message: message)
    }
    
    static func fetchMessagesForThread(threadIdentifier: String, completion: (messages: [Message]) -> Void) {
        FirebaseController.dataAtEndPoint("\(messageEndPoint)/\(threadIdentifier)", completion: { (data) in
            guard let data = data as? [[String : AnyObject]] else { return }
            
            var messages = [Message]()
            
            for dictionary in data {
                if let message = Message(json: dictionary, identifier: "") {
                    messages.append(message)
                }
            }
            
            completion(messages: messages)
            
        })
    }
}