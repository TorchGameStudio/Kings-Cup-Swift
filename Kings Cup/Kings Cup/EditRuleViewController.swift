//
//  EditRuleViewController.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-30.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class EditRuleViewController: UIViewController {
  
    @IBOutlet var ruleName:UITextView!
    @IBOutlet var ruleDescription:UITextView!
    @IBOutlet var header:UITextView!
  
    @IBAction func acceptButtonTapped(AnyObject) {
      
        RuleManager.saveRule(ruleName: ruleName.text, ruleDescription: ruleDescription.text, ruleRange: [ruleValue])
      
        if let parent = parentViewController {
          
            let rulesViewController = parent as RuleListViewController
            rulesViewController.tableView.reloadRowsAtIndexPaths(rulesViewController.tableView.indexPathsForVisibleRows()!, withRowAnimation: UITableViewRowAnimation.None)
          
        }
      
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
      
    }
    
    @IBAction func cancelButtonTapped(AnyObject) {
      
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
      
    }
  
    var ruleValue = Int()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        ruleName.tintColor = UIColor.blackColor()
        ruleDescription.tintColor = UIColor.blackColor()
        header.userInteractionEnabled = false
      
        if let rule = RuleManager.getRuleForValue(ruleValue) {
            ruleName.text = rule.ruleName
            ruleDescription.text = rule.ruleDescription
            header.text = Deck.suitWithValueForCardValue(ruleValue)
        }
      
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
      
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
  
    override func willMoveToParentViewController(parent: UIViewController?) {
      
    }
  
}