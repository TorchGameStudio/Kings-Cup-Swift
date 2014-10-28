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
    @IBOutlet var ruleButton:UIView!
  
  
///--------------------------------------------------
///
/// // MARK: - Overridden Methods
///
///--------------------------------------------------
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.userInteractionEnabled = true
        self.ruleOverlay.alpha = 0
        self.ruleName.alpha = 0
    }
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
      
        deck.shuffle()
        deck.addNewCard()
        deck.cardDrawnBlock = {
          
            self.animateRuleName()
            self.configureRuleText()
          
        }
      
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
      
        var ruleDisplayed = ruleOverlay.alpha != 0
      
        if(!ruleDisplayed) {
          
            deck.drawCard()
          
        } else {
          
            let touch: AnyObject? = touches.anyObject()
            let location = touch?.locationInView(self.view)
            let ruleTapped = CGRectContainsPoint(ruleOverlay.frame, location!)
          
            if ruleTapped {
              
              
              
            } else {
              
                deck.discardDrawnCard()
                deck.addNewCard()
                animateRuleName()
  
            }
          
        }
    }
  
  
///--------------------------------------------------
///
/// // MARK: - Utility Methods
///
///--------------------------------------------------
  
    func configureRuleText() {
      
        let drawnCardValue = deck.cards[0]
      
        if let rule = RuleManager.getRuleForValue(drawnCardValue) {
            ruleName.text = rule.ruleName
        }
      
        ruleName.textColor = UIColor.whiteColor()
        ruleName.textAlignment = NSTextAlignment.Center
        ruleName.font = UIFont.systemFontOfSize(18)
      
    }
  
    func animateRuleName() {
      
        let currentRulesOverlayAlpha = ruleOverlay.alpha
      
        var overlayTargetAlpha:CGFloat
        var nameTargetAlpha:CGFloat
      
        if currentRulesOverlayAlpha != rulesOverlayAlpha {
        
            overlayTargetAlpha = rulesOverlayAlpha
            nameTargetAlpha = 1
            ruleOverlay.alpha = 0
            ruleName.alpha = 0
        
        } else {
        
            overlayTargetAlpha = 0
            nameTargetAlpha = 0
            ruleOverlay.alpha = rulesOverlayAlpha
            ruleName.alpha = 1
        
        }
      
        self.view.bringSubviewToFront(self.ruleName)
      
        UIView.animateWithDuration(0.2, animations: {
          
            self.ruleOverlay.alpha = overlayTargetAlpha
            self.ruleName.alpha = nameTargetAlpha
          
        })
      
    }
  
  
    func animateRuleDescription() {
      
      
    }
  
  
}
