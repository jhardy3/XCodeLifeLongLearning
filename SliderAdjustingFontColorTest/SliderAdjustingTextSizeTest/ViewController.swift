//
//  ViewController.swift
//  SliderAdjustingTextSizeTest
//
//  Created by Jake Hardy on 4/9/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testFontColorLabel: UILabel!
    @IBOutlet weak var testFontColorSlider: UISlider!
    
    var textColor = UIColor(colorLiteralRed: 1/255, green: 1/255, blue: 1/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testFontColorSlider.maximumValue = 255.0
        testFontColorSlider.minimumValue = 0.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func testFontColorSliderFired(sender: UISlider) {
        let colorValue = sender.value
        
        let color = UIColor(colorLiteralRed: colorValue / 255.0, green: colorValue / 255.0, blue: colorValue / 255.0, alpha: 1.0)
        
        testFontColorLabel.textColor = color
    }


}

