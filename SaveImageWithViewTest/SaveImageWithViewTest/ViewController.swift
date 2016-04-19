//
//  ViewController.swift
//  SaveImageWithViewTest
//
//  Created by Jake Hardy on 4/8/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testImageView.userInteractionEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func theTestTap(sender: UITapGestureRecognizer) {
        guard let image = ImageUitilies.createImageWithViewOnTop(backgroundImage: testImageView, view: testLabel)
            else { return }
        
        self.testImageView.image = image
        
        print("I just saved a picture!")
    }

}

