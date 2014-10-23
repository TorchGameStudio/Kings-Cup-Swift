//
//  RuleManager.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-23.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RuleManager {
  
    class var sharedInstance: RuleManager {
        struct Static {
            static var instance: RuleManager?
            static var token: dispatch_once_t = 0
            }
            
            dispatch_once(&Static.token) {
              Static.instance = RuleManager()
            }
        
        return Static.instance!
    }
  
  
    func saveRule(#rule:Rule) {
      
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Rule", inManagedObjectContext: managedContext)
        
        let ruleManagedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)

        ruleManagedObject.setValue(rule.ruleName, forKey: "ruleName")
        ruleManagedObject.setValue(rule.ruleDescription, forKey: "ruleDescription")
        ruleManagedObject.setValue(rule.range, forKey: "range")
      
        var error:NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
  
//    class func getRuleForValue(value:Int) -> Rule {
//      
//      
//      
//    }
  
}
