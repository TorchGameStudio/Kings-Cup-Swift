//
//  Contants.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-21.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import Foundation
import SpriteKit

enum Suits {
 
  case Spades, Hearts, Clubs, Diamonds
  
}

let screenSize = UIScreen.mainScreen().bounds.size
let textMargins:CGFloat = 20

let deckImages = 6
let deckSize = 52
let cardsPerSuit = 13

let rulesOverlayAlpha:CGFloat = 0.85
let ruleNameFontSize:CGFloat = 15

// NOTIFICATIONS

let CardFlippedNotification = "CardFlippedNotification"

// EXTENSION

extension UIView {
  
  func setFrameWidth(width:CGFloat) {
    var frame = self.frame
    frame.size.width = width
    self.frame = frame
  }
  
  func setFrameHeight(height:CGFloat) {
    var frame = self.frame
    frame.size.height = height
    self.frame = frame
  }
  
  func setFrameX(x:CGFloat) {
    var frame = self.frame
    frame.origin.x = x
    self.frame = frame
  }
  
  func setFrameY(y:CGFloat) {
    var frame = self.frame
    frame.origin.y = y
    self.frame = frame
  }

}

extension Array {
  mutating func removeObject<U: Equatable>(object: U) {
    var index: Int?
    for (idx, objectToCompare) in enumerate(self) {
      if let to = objectToCompare as? U {
        if object == to {
          index = idx
        }
      }
    }
    
    if(index != nil) {
      self.removeAtIndex(index!)
    }
  }
}

class UILabelWithMargin : UILabel {
 
  override func drawTextInRect(rect: CGRect) {
    
    var insets:UIEdgeInsets = UIEdgeInsets(top: textMargins, left: textMargins, bottom: textMargins, right: textMargins)
    super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    
  }
}