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
let cardSize = CGSize(width: screenSize.width/1.8, height: screenSize.height/1.8)

let deckImages = 6
let deckSize = 52
let cardsPerSuit = 13

let rulesOverlaySize = CGSize(width: screenSize.width, height: cardSize.height/2)
let rulesOverlayAlpha:CGFloat = 0.9
let ruleNameFontSize:CGFloat = 15

// NOTIFICATIONS

let CardFlippedNotification = "CardFlippedNotification"

// EXTENSIONS

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

extension Rule {
  
}