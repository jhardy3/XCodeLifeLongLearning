//
//  ThreadController.swift
//  SimpleChatFirebaseTest
//
//  Created by Jake Hardy on 4/11/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit

class ThreadController {
    
    static func createThread(threadName: String, tableview: UITableView, viewController: FirebaseChatManager, completion: (thread: Thread, threadManager: FirebaseChat?) -> Void) {
        var thread = Thread(threadName: threadName)
        thread.save()
        
        guard let currentThreadID = thread.identifier else { return }
        let chatManager = FirebaseChat(tableview: tableview, viewController: viewController, threadIdentifier: currentThreadID)
        
        completion(thread: thread, threadManager: chatManager)
    }
    
    // Creates a chat at an endpoint specified by a user. Consolidates endpoints (Used for Relief April 12, 2016)
    static func createThreadWithIdentifier(threadIdentifier: String, tableview: UITableView, viewController: FirebaseChatManager, completion: (threadManager: FirebaseChat?) -> Void) {
        
        let threadManager = FirebaseChat(tableview: tableview, viewController: viewController, threadIdentifier: threadIdentifier)
        
        completion(threadManager: threadManager)
    }
    
}
