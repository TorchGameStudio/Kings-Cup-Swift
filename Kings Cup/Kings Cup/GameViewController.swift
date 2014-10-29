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
    @IBOutlet var ruleLabel:UILabelWithMargin!
    @IBOutlet var ruleButton:UIView!
  
    var ruleDescription:UITextView = UITextView()
  
///--------------------------------------------------
///
/// // MARK: - Overridden Methods
///
///--------------------------------------------------
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.userInteractionEnabled = true
        initUI()
    }
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
      
        deck.shuffle()
        deck.addNewCard()
        deck.cardDrawnBlock = {
          
            self.animateRuleName()
            self.setRuleName()
            self.setRuleDescription()
          
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
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
  
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
      
        var ruleNameDisplayed = ruleLabel.alpha != 0
        var ruleDescriptionDisplayed = ruleDescription.alpha != 0
      
        if(!ruleNameDisplayed && !ruleDescriptionDisplayed) {
          
            deck.drawCard()
          
        } else {
          
            let touch: AnyObject? = touches.anyObject()
            let location = touch?.locationInView(self.view)
            let ruleTapped = (ruleNameDisplayed && CGRectContainsPoint(ruleLabel.frame, location!)) || (ruleDescriptionDisplayed && CGRectContainsPoint(ruleDescription.frame, location!))
          
            if ruleTapped {
              
                toggleRuleNameDescription()
              
            } else {
              
                deck.discardDrawnCard()
                deck.addNewCard()
                animateRuleName()
                ruleDescription.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  
            }
          
        }
    }
  
  
///--------------------------------------------------
///
/// // MARK: - Utility Methods
///
///--------------------------------------------------
  
  
    func initUI() {
      
        ruleLabel.alpha = 0
      
        ruleDescription = UITextView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        ruleDescription.backgroundColor = UIColor.blackColor()
        ruleDescription.textColor = UIColor.whiteColor()
        ruleDescription.font = UIFont.systemFontOfSize(17)
        ruleDescription.userInteractionEnabled = false
        ruleDescription.textAlignment = NSTextAlignment.Center
        ruleDescription.alpha = 0
        ruleDescription.contentHuggingPriorityForAxis(UILayoutConstraintAxis.Horizontal)
      
        self.view.addSubview(ruleDescription)
      
    }
  
    func animateRuleName() {
      
        let currentRulesOverlayAlpha = ruleLabel.alpha
        var ruleLabelTargetAlpha:CGFloat
      
        if currentRulesOverlayAlpha != rulesOverlayAlpha {
        
            ruleLabelTargetAlpha = rulesOverlayAlpha
            ruleLabel.alpha = 0
        
        } else {
        
            ruleLabelTargetAlpha = 0
            ruleLabel.alpha = rulesOverlayAlpha
        
        }
      
        self.view.bringSubviewToFront(self.ruleLabel)
      
        UIView.animateWithDuration(0.2, animations: {
          
            self.ruleLabel.alpha = ruleLabelTargetAlpha
          
        })
      
    }
  
    func toggleRuleNameDescription() {
      
        var ruleNameShowing = ruleLabel.alpha != 0
      
        if ruleNameShowing {
          
            ruleLabel.alpha = 0
            ruleDescription.alpha = rulesOverlayAlpha
          
          
        } else {
          
            ruleLabel.alpha = rulesOverlayAlpha
            ruleDescription.alpha = 0
          
        }
      
    }
  
    func setRuleName() {
      
        let drawnCardValue = deck.cards[0]
        
        if let rule = RuleManager.getRuleForValue(drawnCardValue) {
          
          ruleLabel.text = rule.ruleName
          
        }
      
    }
  
    func setRuleDescription() {
      
      let drawnCardValue = deck.cards[0]
      
      if let rule = RuleManager.getRuleForValue(drawnCardValue) {
        
        
        
          ruleDescription.text = "SOME REALLY LONG TEXT TO TEST OUT SOME STUFF AND FINALLY GET THIS SILLY CENTERING TO WORK PROPERLY"
          ruleDescription.textContainer.size.height = screenSize.height

          var topOffset = (screenSize.height - ruleDescription.contentSize.height)/2
          topOffset = topOffset < 0.0 ? 0.0 : topOffset
          ruleDescription.textContainerInset.top = topOffset
          ruleDescription.textContainer.size.height += topOffset
        
      }
      
    }
  
  
}
