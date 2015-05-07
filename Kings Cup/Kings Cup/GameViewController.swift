//
//  GameViewController.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-04.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
///--------------------------------------------------
///
/// // MARK: - Interface Elements
///
///--------------------------------------------------
  
    @IBOutlet var deck:Deck!
    @IBOutlet var ruleLabel:UILabelWithMargin!
    @IBOutlet var ruleButton:UIView!
  
    @IBAction func rulesButtonTapped(AnyObject) {
      
        var storyboard = self.storyboard
        var ruleListViewController = storyboard?.instantiateViewControllerWithIdentifier("RuleListViewController") as RuleListViewController
        addChildViewController(ruleListViewController)
        view.addSubview(ruleListViewController.view)
      
    }
  
///--------------------------------------------------
///
/// // MARK: - Variables
///
///--------------------------------------------------
  
    var ruleDescription:UITextView = UITextView()
    var ruleShowing:Bool = false;
  
///--------------------------------------------------
///
/// // MARK: - Overridden Methods
///
///--------------------------------------------------
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.userInteractionEnabled = true
        ruleLabel.alpha = 0
        initRuleDescriptionView()
    }
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
      
        deck.shuffle()
        deck.addNewCard()
        deck.cardDrawnBlock = {
          
            self.animateRuleName()
            self.setRuleDescriptionTextPosition()
          
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
      
        var rulesListShowing = self.childViewControllers.count > 0
      
        if rulesListShowing {
          
          return
          
        }
      
        var ruleNameDisplayed = ruleLabel.alpha != 0
        var ruleDescriptionDisplayed = ruleDescription.alpha != 0
      
        if(!ruleNameDisplayed && !ruleDescriptionDisplayed) {
          
            deck.drawCard()
            self.setRuleName()
            self.setRuleDescription()
          
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
                resetRuleDescriptionContent()
              
            }
          
        }
    }
  
  
///--------------------------------------------------
///
/// // MARK: - Utility Methods
///
///--------------------------------------------------
  
  
    func initRuleDescriptionView() {
      
        ruleDescription.removeFromSuperview()
        var textViewFrame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        ruleDescription = UITextView(frame: textViewFrame)
        ruleDescription.backgroundColor = UIColor.blackColor()
        ruleDescription.textColor = UIColor.whiteColor()
        ruleDescription.font = UIFont.systemFontOfSize(17)
        ruleDescription.userInteractionEnabled = false
        ruleDescription.textAlignment = NSTextAlignment.Center
        ruleDescription.alpha = 0
        resetRuleDescriptionContent()
        self.view.addSubview(ruleDescription)
      
    }
  
    func animateRuleName() {
      
        let currentRulesOverlayAlpha = ruleLabel.alpha
        var ruleLabelTargetAlpha:CGFloat
      
        if !ruleShowing {
        
            ruleLabelTargetAlpha = rulesOverlayAlpha
            ruleLabel.alpha = 0
            ruleShowing = true;
        
        } else {
        
            ruleLabelTargetAlpha = 0
            ruleLabel.alpha = rulesOverlayAlpha
            ruleShowing = false
            
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
        
          ruleDescription.text = rule.ruleDescription
        
      }
      
    }
  
    func setRuleDescriptionTextPosition() {
        
        var topOffset = ruleDescription.bounds.height/2 - ruleDescription.contentSize.height/2
        topOffset = topOffset < 0.0 ? 0.0 : topOffset
        
        ruleDescription.textContainerInset.top = screenSize.height/2 - ruleDescription.contentSize.height/2
        ruleDescription.textContainer.size.height = screenSize.height/2 + ruleDescription.contentSize.height/2
      
    }
  
    func resetRuleDescriptionContent() {
      
      ruleDescription.textContainerInset = UIEdgeInsets(top: 0, left: textMargins, bottom: 0, right: textMargins)
      ruleDescription.textContainer.size.height = ruleDescription.contentSize.height
      
    }
  
}
