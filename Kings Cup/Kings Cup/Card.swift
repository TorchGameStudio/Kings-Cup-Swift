//
//  Card.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-17.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import Foundation
import SpriteKit

class Card :SKSpriteNode {
  
  ///--------------------------------------------------
  /// // MARK: Variables
  ///--------------------------------------------------
  
  var value:Int = 0;
  
  ///--------------------------------------------------
  /// // MARK: Methods
  ///--------------------------------------------------
  
  init(cardValue value: Int) {
    
    super.init(texture: cardBackTexture, color: nil, size: CGSize(width: 0,height: 0))
    
    self.value = value;
    self.userInteractionEnabled = true
    
  }
 
  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    
    
    
  }
  
  
 
}