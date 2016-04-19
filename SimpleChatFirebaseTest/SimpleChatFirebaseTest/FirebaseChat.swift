//
//  FirebaseChat.swift
//  SimpleChatFirebaseTest
//
//  Created by Jake Hardy on 4/11/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit

let threadEndPoint = "thread"
let messageEndPoint = "message"

class FirebaseChat {
    
    var messages = [Message]()
    
    var tableview: UITableView
    var viewController: UIViewController
    var threadID: String
    
    init?(tableview: UITableView, viewController: FirebaseChatManager, threadIdentifier: String) {
        guard let viewController = viewController as? UIViewController else { return nil }
        
        self.viewController = viewController
        self.tableview = tableview
        self.threadID = threadIdentifier
        
        observeChat()
        fetchMessages()
    }
    
    func observeChat() {
        FirebaseController.observeDataAtEndPoint("\(messageEndPoint)/\(threadID)", completion:  { (data) in
            
            guard let messageData = data as? [String : AnyObject] else { return }
            guard let id = data?.identifier, message = Message(json: messageData, identifier: id) else { return }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.insertMessageIntoTableview(message)
            })
        })
    }
    
    func insertMessageIntoTableview(message: Message) {
        self.messages.append(message)
        
        tableview.beginUpdates()
        let indexPath = NSIndexPath(forRow: messages.count - 1, inSection: 0)
        tableview.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        tableview.endUpdates()
    }
    
    func messagePosted(textField: UITextField, username: String) {
        guard let bodyText = textField.text where bodyText.isEmpty == false else { return }
        MessageController.createMessage(threadID, bodyText: bodyText, username: username) { (message) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.insertMessageIntoTableview(message)
            })
        }
    }
    
    func fetchMessages() {
        MessageController.fetchMessagesForThread(threadID) { (messages) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.messages.appendContentsOf(messages)
                self.tableview.reloadData()
            })
            
        }
    }
}


protocol FirebaseChatManager {
    
    var chatManager: FirebaseChat! { get }
    weak var tableview: UITableView! { get }
    weak var messageTextField: UITextField! { get }
    
}