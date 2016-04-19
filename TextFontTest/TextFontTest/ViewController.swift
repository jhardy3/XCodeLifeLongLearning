//
//  ViewController.swift
//  TextFontTest
//
//  Created by Jake Hardy on 4/8/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var textTestLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var fontNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        let fontFamilyNames = UIFont.familyNames()
        fontNames = fontFamilyNames
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontNames.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        if let view = view as? UILabel {
            return view
        } else {
            let view = UILabel()
            view.text = fontNames[row]
            view.font = UIFont(name: fontNames[row], size: 30)
            view.textAlignment = .Center
            return view
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let font = fontNames[row]
        
        textTestLabel.font = UIFont(name: font, size: 17)
    }

}

