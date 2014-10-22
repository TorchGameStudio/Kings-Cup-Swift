//
//  GameScene.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-04.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
    // MARK: Variables
  
    var deck:Deck = Deck()
  
    // MARK: Methods
  
    required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  
    override init(size: CGSize) {
      super.init(size: size)
    }
  
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
      
        view.addSubview(deck)
        self.backgroundColor = UIColor.whiteColor()
    }
  
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
