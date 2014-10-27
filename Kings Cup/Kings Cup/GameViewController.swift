//
//  GameViewController.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-04.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
    ///--------------------------------------------------
    ///
    /// // MARK: - Variables
    ///
    ///--------------------------------------------------
  
    @IBOutlet var deck:Deck!
    @IBOutlet var ruleOverlay:UIView!
    @IBOutlet var ruleName:UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.userInteractionEnabled = true
    }
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        deck.initCards()
        self.view.bringSubviewToFront(ruleOverlay)
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.toRaw())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
  
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        deck.drawCard()
    }
}
