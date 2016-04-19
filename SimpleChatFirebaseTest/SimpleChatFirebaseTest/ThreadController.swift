//
//  ThreadController.swift
//  SimpleChatFirebaseTest
//
//  Created by Jake Hardy on 4/11/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation

class ThreadController {
    
    static func createThread(threadName: String, completion: (thread: Thread, threadManager: FirebaseChat) -> Void) {
        var thread = Thread(threadName: threadName)
        thread.save()
        
        guard let currentThreadID = thread?.identifier else { return }
        chatManager = FirebaseChat(tableview: self.tableview, viewController: self, threadIdentifier: currentThreadID)
        
        completion(thread: thread, threadManager: chatManager)
    }
    
}
