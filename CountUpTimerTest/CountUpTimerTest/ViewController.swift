//
//  ViewController.swift
//  CountUpTimerTest
//
//  Created by Jake Hardy on 4/21/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TimerDelegate {

    var timer = Timer()
        
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func stopTimerTapped(sender: UIButton) {
        timer.stopTimer()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButtonTapped(sender: UIButton) {
        timer.startTimer()
    }
    
    func updatedTimeString(time: String) {
        timerLabel.text = time
    }

}

