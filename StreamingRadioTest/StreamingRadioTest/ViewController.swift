//
//  ViewController.swift
//  StreamingRadioTest
//
//  Created by Jake Hardy on 4/26/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import AVFoundation
import SafariServices

class ViewController: UIViewController {
    
    //  http://us1.internet-radio.com:8105/
    // http://crystalout.surfernetwork.com:8001/KFNX_MP3
    // http://stream.kcaastreaming.com:8000/kcaa.mp3
    // http://fire.wavestreamer.com:8841
    
    var avPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url:NSURL = NSURL(string: "http://65.19.131.171/alphaportland-kufoamaac-ibc1?session-id=1128215199")!
        
        let avPlayer = AVPlayer(URL: url)
        self.avPlayer = avPlayer
        avPlayer.volume = 1.0
        
        print(avPlayer.play())
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

