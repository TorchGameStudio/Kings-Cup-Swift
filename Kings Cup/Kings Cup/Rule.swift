//
//  Rule.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-23.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import Foundation
import CoreData

class Rule: NSManagedObject {

    @NSManaged var range: AnyObject
    @NSManaged var ruleName: String
    @NSManaged var ruleDescription: String

}
