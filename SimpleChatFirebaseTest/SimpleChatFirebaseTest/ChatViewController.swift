//
//  ChatViewController.swift
//  SimpleChatFirebaseTest
//
//  Created by Jake Hardy on 4/11/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, FirebaseChatManager{
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var chatManager: FirebaseChat!
    
    var currentThread: Thread?
    var currentUser = "fred"
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonTapped(sender: UIButton) {
        chatManager?.messagePosted(messageTextField, username: currentUser)
        
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatManager.messages.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath)
        let message = chatManager.messages[indexPath.row]
        
        cell.textLabel?.text = message.messageBodyText
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
