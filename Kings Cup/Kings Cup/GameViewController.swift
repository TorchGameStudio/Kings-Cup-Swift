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
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if let scene = GameScene.sceneWithSize(view.bounds.size) {
        // Configure the view.
        let skView = self.view as SKView
      
        skView.showsFPS = true
            
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFit
            
        skView.presentScene(scene)
      }
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
        
        return Int(UIInterfaceOrientationMask.Portrait.toRaw())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}
