//
//  RuleListViewController.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-30.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class RuleListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet var tableView:UITableView!
  
    @IBAction func ruleButtonTapped(AnyObject) {
      
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
      
    }
  
    @IBAction func defaultButtonTapped(AnyObject) {
      
        RuleManager.configureDefaultRules()
        tableView.reloadRowsAtIndexPaths(tableView.indexPathsForVisibleRows()!, withRowAnimation: UITableViewRowAnimation.None)
      
    }
  
    @IBAction func newRuleButtonTapped(AnyObject) {
      
        
      
    }
  
    var selectedCardValue = Int()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        var ruleListCell = UINib(nibName: "RuleTableViewCell", bundle: nil)
        tableView.registerNib(ruleListCell, forCellReuseIdentifier: "cell")
        self.tableView.layer.borderWidth = 1.0
        self.tableView.layer.borderColor = UIColor.grayColor().CGColor

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
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deckSize
    }
  
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cell:RuleTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as RuleTableViewCell
        return cell.frame.height
    }
  
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
        var storyboard = self.storyboard
        var editRuleViewController = storyboard?.instantiateViewControllerWithIdentifier("EditRuleViewController") as EditRuleViewController
        editRuleViewController.ruleValue = indexPath.row + 1
        addChildViewController(editRuleViewController)
        view.addSubview(editRuleViewController.view)
      
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        var cell:RuleTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as RuleTableViewCell
        
        if let rule = RuleManager.getRuleForValue(indexPath.row + 1) {
         
            cell.ruleName.text = rule.ruleName
            cell.cardValue.text = Deck.suitWithValueForCardValue(indexPath.row + 1)
          
        }
      
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
  
}