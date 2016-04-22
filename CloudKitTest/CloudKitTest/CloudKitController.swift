//
//  CloudKitController.swift
//  CloudKitTest
//
//  Created by Jake Hardy on 4/21/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    
    static let sharedController = CloudKitController()
    let publicDB = CKContainer.defaultContainer().publicCloudDatabase
    
    
    func createNSOperationDependency() {
        let firstFetch = CKFetchRecordsOperation()
        let secondFetch = CKFetchRecordsOperation()
        
        secondFetch.addDependency(firstFetch)
        
        let queue = NSOperationQueue()
        queue.addOperations([firstFetch, secondFetch], waitUntilFinished: false)
    }
    
    func saveRecordToPublicDatabase(record: CKRecord) {
        
        publicDB.saveRecord(record) { (record, error) in
            if let retryAfterValue = error?.userInfo[CKErrorRetryAfterKey] as? NSTimeInterval {
                let retryAfterDate = NSDate(timeIntervalSinceNow: retryAfterValue)
            }
            guard let record = record else { return }
            // Do Something with record
        }
    }
    
    func readRecordFromPublicDatabase(recordID: CKRecordID) {
        
        publicDB.fetchRecordWithID(recordID) { (record, error) in
            if let error = error {
                print(error)
            }
            
            guard let record = record else { return }
            // Do Something with record
        }
    }
    
    func editRecordFromPublicDatabase(recordID: CKRecordID) {
        
        // ???
        createNSOperationDependency()
        
        publicDB.fetchRecordWithID(recordID) { (record, error) in
            if let error = error {
                print(error)
            }
            guard let record = record else { return }
            
            // Do stuff here
            
            self.publicDB.saveRecord(record, completionHandler: { (record, error) in
                // Saved
            })
            
        }
    }
    
    func queryWithPredicateAndType(type: String, predicate: NSPredicate) {
        
        let query = CKQuery(recordType: type, predicate: predicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (records, error) in
            if let error = error {
                 print("Error in \(#function) - \(error.localizedDescription)")
            }
        }
        // Do something with records
    }
    
    
}