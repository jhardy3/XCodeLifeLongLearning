//
//  SecondViewController.swift
//  SWRevealViewControllerTest
//
//  Created by Jake Hardy on 4/12/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit
import MapKit

enum ToggleMode {
    case MapShown
    case MapHidden
}

class SecondViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate , SWRevealViewControllerDelegate {

    var toggleMode = ToggleMode.MapShown
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().delegate = self
        self.mapView.delegate = self
        self.toggleMap()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tabBarTapped(sender: UIBarButtonItem) {
       toggleMap()
    }

    @IBAction func tapGestureFired(sender: UITapGestureRecognizer) {
        if toggleMode == .MapHidden {
            toggleMap()
        }
    }
    
    
    
    func toggleMap() {
        switch toggleMode {
        case .MapHidden:
            toggleMode = .MapShown
            self.revealViewController().revealToggle(self)
            
        case .MapShown:
            toggleMode = .MapHidden
            self.revealViewController().revealToggle(self)
        }

    }

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
       toggleMap()
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
