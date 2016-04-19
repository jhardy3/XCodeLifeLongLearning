//
//  FirebaseChat.swift
//  SimpleChatFirebaseTest
//
//  Created by Jake Hardy on 4/11/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit



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
    }
    
    func observeChat() {
        MessageController.observeMessagesForThread(threadID) { (message) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.insertMessageIntoTableview(message)
            })
        }
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
        MessageController.createMessage("1", threadID: threadID, bodyText: bodyText, username: username) { (succes) in
            if succes {
                print("Oh snap Mr. Lewis")
                // Change this function - complete with success bool param
            }
        }
    }
}


protocol FirebaseChatManager {
    
    var chatManager: FirebaseChat? { get }
    weak var tableview: UITableView! { get }
    weak var messageTextField: UITextField! { get }
    
}