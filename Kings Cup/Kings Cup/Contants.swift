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
let cardSize = CGSize(width: screenSize.width/1.3, height: screenSize.height/1.5)

let deckImages = 6
let deckSize = 52
let cardsPerSuit = 13

// NOTIFICATIONS

let CardFlippedNotification = "CardFlippedNotification"

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