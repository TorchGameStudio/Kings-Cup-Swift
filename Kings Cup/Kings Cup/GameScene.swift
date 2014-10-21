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
  
    var deck:Deck
  
    // MARK: Methods
  
    required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  
    override init(size: CGSize) {
      deck = Deck()
      
      super.init(size: size)
      
      self.addChild(deck)
    }
  
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
      
        self.backgroundColor = UIColor.whiteColor()
      
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        /* Called when a touch begins */
//        
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//            //let sprite = SKSpriteNode(imageNamed:"Spaceship")
//          
//        }
//    }
  
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
