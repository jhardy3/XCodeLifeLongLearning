//
//  ViewController.swift
//  ScalableTextFieldTest
//
//  Created by Jake Hardy on 4/24/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func returnStringOfLength(length: Int) -> String {
        var emptyString = ""
        
        for _ in 0...length {
            emptyString += "a"
        }
        
        return emptyString
    }
    
    
    func scaleStringBasedOnLength(string: String) {
        var stringLength = string.characters.count
        
    }
    

}

