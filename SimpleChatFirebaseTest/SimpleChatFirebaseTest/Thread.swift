//
//  Thread.swift
//  SimpleChatFirebaseTest
//
//  Created by Jake Hardy on 4/11/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation

let THREAD_NAME_KEY = "threadName"

class Thread: FirebaseType {
    
    var threadName: String
    var endpoint = threadEndPoint
    var identifier: String?
    
    var jsonValue: [String : AnyObject] {
        get {
            return ["1" : 0]
        }
    }
    
    required init?(json: [String : AnyObject], identifier: String) {
        
        guard let threadName = json[THREAD_NAME_KEY] as? String else { return nil }
        
        self.threadName = threadName
    }
    
    init(threadName: String) {
        self.threadName = threadName
    }
    
}