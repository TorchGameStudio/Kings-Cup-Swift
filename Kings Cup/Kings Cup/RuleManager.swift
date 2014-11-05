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
      
        for ruleValue in ruleRange {
          
            if let rule = RuleManager.getRuleForValue(ruleValue)
            {
                var ruleRange = rule.range as [Int]
                ruleRange.removeObject(ruleValue)
                rule.range = ruleRange
            }
          
            if let rule = RuleManager.getRuleForValue(ruleValue)
            {
              var a = rule.ruleDescription
              var v = ""
          }
          
        }
      
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
  
    class func getRuleForValue(value:Int) -> Rule? {
      
        var rules = getRules()
        var ruleForValue:AnyObject?
      
        for rule in rules {
          
            let ruleRange = rule.range as [Int]
            if NSArray(array: ruleRange).containsObject(value)  {
              ruleForValue = rule as Rule
            }
          
        }
      
        return ruleForValue as Rule?
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
  
    class func configureDefaultRules() {
      
        if let path = NSBundle.mainBundle().pathForResource("DefaultRules", ofType: "json") {
        
            let jsonData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
            let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error:nil) as NSDictionary
        
            var rules: NSArray = json["defaultRules"] as NSArray
        
        
            var ruleIndex = cardsPerSuit
            for rule in rules {
              
                var ruleRange = [Int]()
                let ruleName = rule["name"] as NSString
                let ruleDescription = rule["description"] as NSString
              
                ruleRange.append(ruleIndex + (cardsPerSuit * Suits.Spades.hashValue))
                ruleRange.append(ruleIndex + (cardsPerSuit * Suits.Clubs.hashValue))
                ruleRange.append(ruleIndex + (cardsPerSuit * Suits.Hearts.hashValue))
                ruleRange.append(ruleIndex + (cardsPerSuit * Suits.Diamonds.hashValue))
                
                ruleIndex--
                RuleManager.saveRule(ruleName: ruleName, ruleDescription: ruleDescription, ruleRange: ruleRange)
            }
        }
    }
  
}
