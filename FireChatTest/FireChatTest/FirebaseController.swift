//
//  NetworkController.swift
//  Tine
//
//  Created by Jake Hardy on 3/22/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import Firebase


class FirebaseController {
    
    static private let baseURL = "chattestgeneral.firebaseIO.com"
    
    // Declare a static base variable for firebase communication
    static let firebase = Firebase(url: baseURL)
    
    // Declare a static function that returns a single snapshot of data at a specific point in firebase data structure
    static func dataAtEndPoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        
        // Using the endpoint, construct a new base from which to find data at. The endpoint is passed in and appended to the original firebase variable
        let endpointBase = firebase.childByAppendingPath(endpoint)
        
        // Observe single value event once at specific moment
        endpointBase.observeSingleEventOfType(.Value, withBlock: { (data) -> Void in
            
            // check data for null else return nil
            guard let data = data.value else { completion(data: nil) ; return }
            
            // complete with data
            completion(data: data)
            
        })
    }
    
    // Declare a static function that will continually observe a specific endpoit value in firebase and return data from it
    static func observeDataAtEndPoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        
        // Using endpoint, construct a new firebase route and observe data at it
        let endpointBase = firebase.childByAppendingPath(endpoint)
        
        // Observe endpoint
        endpointBase.observeEventType(.Value, withBlock: { (data) -> Void in
            
            // Check data for null, if null complete nil
            guard let data = data.value else { completion(data: nil) ; return }
            
            // Complete with data
            completion(data: data)
            
        })
    }

    // Declare a static function that will continually observe a specific endpoit value in firebase and return data from it
    // When a child is added
    static func observeChildAtEndPoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        
        // Using endpoint, construct a new firebase route and observe data at it
        let endpointBase = firebase.childByAppendingPath(endpoint)
        
        // Observe endpoint
        endpointBase.observeEventType(.ChildAdded, withBlock: { (data) -> Void in
            
            // Check data for null, if null complete nil
            guard let data = data.value else { completion(data: nil) ; return }
            
            // Complete with data
            completion(data: data)
            
        })
    }
    
    static func observeDataAtEndPointOnce(endpoint: String, completion: (data: AnyObject?) -> Void) {
        
        // Using endpoint, construct a new firebase route and observe data at it
        let endpointBase = firebase.childByAppendingPath(endpoint)
        
        // Observe endpoint
        endpointBase.observeSingleEventOfType(.Value, withBlock: { (data) -> Void in
            
            // Check data for null, if null complete nil
            guard let data = data.value else { completion(data: nil) ; return }
            
            // Complete with data
            completion(data: data)
            
        })
    }
}

// MARK: - FirebaseType Protocol
protocol FirebaseType {
    
    // Identifier will be an optional string (assigned when object is created in firebase .childByAutoID())
    var identifier: String? { get set }
    
    // Endpoint is a required string used to define the path that must be traversed in firebase for access
    var endpoint: String { get }
    
    // JSON Value is a computed dictionary that will be used to store the various attributes of model objects in firebase
    var jsonValue: [String : AnyObject] { get }
    
    // Failable initializer that utilizes a JSON formatted dictionary to initialize a partiular model object. Requires identifier for initialization
    init?(json: [String : AnyObject], identifier: String)
    
    // Mutating func save alters the data, updates the model and pushes to firebase
    mutating func save()
    
    // Deletes data in firebase
    func delete()
    
}

// MARK: - FirebaseType Extension
extension FirebaseType {
    
    // All objects conforming to FirebaseType will implement the following save function. This implementation checks for an identifier, if identifier is present the identifier is passed into childByAppendingPath. If not, a new ID is generated. The Firebase location is then updated with the jsonValue of the respective path
    mutating func save() {
        
        // An endpoint base is declared
        var endpointBase: Firebase
        
        // Identifier prevalence is checked
        if let identifier = self.identifier {
            
            // If Identifier is present create the endpointBase with identifier ; the endpoint is used to create correct path
            endpointBase = FirebaseController.firebase.childByAppendingPath(endpoint).childByAppendingPath(identifier)
        } else {
            
            // If Identifier isnt present create path using endpoint and generate a new identifier
            endpointBase = FirebaseController.firebase.childByAppendingPath(endpoint).childByAutoId()
            self.identifier = endpointBase.key
        }
        
        // Update value at endpointBase path with objects jsonValue
        endpointBase.updateChildValues(jsonValue)
    }
    
    // Uses endpoint and identifier to construct a path and remove jsonValue at the path's value
    func delete() {
        
        // Check for identifier
        guard let identifier = self.identifier else { return }
        
        // Construct delete base
        let deleteBase = FirebaseController.firebase.childByAppendingPath(endpoint).childByAppendingPath(identifier)
        
        // Delete values
        deleteBase.removeValue()
        
    }
}