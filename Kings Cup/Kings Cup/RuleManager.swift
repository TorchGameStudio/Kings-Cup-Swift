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
  
    class func saveRule(#ruleName:NSString, ruleDescription:NSString, ruleRange:[Int]) {
      
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
        if let managedObjectContext = appDelegate.managedObjectContext {
          
            let entity = NSEntityDescription.entityForName("Rule", inManagedObjectContext: managedObjectContext)
            
            let ruleManagedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
            
            ruleManagedObject.setValue(ruleName, forKey: "ruleName")
            ruleManagedObject.setValue(ruleDescription, forKey: "ruleDescription")
            ruleManagedObject.setValue(ruleRange, forKey: "range")
            
            var error:NSError?
            if !managedObjectContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
          
        }
      
    }
  
    class func getRuleForValue(value:Int) -> Rule {
      
        var rules = getRules()
        var ruleForValue:Rule = Rule()
      
        for rule in rules {
          
            
          
        }
      
        return ruleForValue
    }
  
    class func getRules() -> [Rule] {
      
        var rules = [Rule]()
      
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Rule")
      
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
          error: &error) as [Rule]?
        
        if let results = fetchedResults {
          rules = results
        } else {
          println("Could not fetch \(error), \(error!.userInfo)")
        }
      
        return rules
    }
  
}
