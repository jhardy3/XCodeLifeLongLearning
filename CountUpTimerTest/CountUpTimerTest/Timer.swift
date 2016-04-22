//
//  Timer.swift
//  CountUpTimerTest
//
//  Created by Jake Hardy on 4/21/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation

class Timer {
    
    var time = 0.0
    var timer: NSTimer?
    var delegate: TimerDelegate?
    
    @objc func updateTime() {
        time += 0.01
        
        var elapsedTime: NSTimeInterval = NSTimeInterval(time)
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let fraction = UInt8(elapsedTime * 100)
        
        let strMinutes = String(minutes)
        let strSeconds = String(seconds)
        let strFraction = String(fraction)
        
        delegate?.updatedTimeString("\(strMinutes):\(strSeconds):\(strFraction)")
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        timer?.invalidate()
    }
}

protocol TimerDelegate {
    func updatedTimeString(time: String)
}

