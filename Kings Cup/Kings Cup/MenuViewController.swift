//
//  MenuViewController.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-14.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var rulesButton: UIButton!
    
    @IBAction func playButtonTapped() {
     
        self.performSegueWithIdentifier("ShowGame", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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