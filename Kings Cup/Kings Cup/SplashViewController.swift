//
//  SplashViewController.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-14.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import UIKit
import SpriteKit

class SplashViewController: UIViewController {
    
    @IBOutlet var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.alpha = 0;
        
        UIView.animateWithDuration(0.7, delay: 0.0, options: .CurveEaseOut, animations: {
            
            self.logo.alpha = 1
            
            }, completion: { finished in
                
                self.goToMainMenuAfterDelay(2.0)
                
        })
    }
    
    func goToMainMenuAfterDelay(delay:Double) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.performSegueWithIdentifier("ShowMenu", sender: nil)
        })
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        
        return Int(UIInterfaceOrientationMask.Portrait.toRaw());
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}