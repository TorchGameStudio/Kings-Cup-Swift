//
//  Deck.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-17.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import Foundation
import SpriteKit

class Deck :SKSpriteNode {

  
    required init(coder aDecoder: NSCoder) {
      
        fatalError("init(coder:) has not been implemented")
      
    }
    
    
    ///--------------------------------------------------
    /// // MARK: Variables
    ///--------------------------------------------------
    
    var cards :[Int] = []
    
    ///--------------------------------------------------
    /// // MARK: Init Methods
    ///--------------------------------------------------
    
    
    override init() {
      
      super.init(texture: deckTextures.textureNamed("Deck1"), color: nil, size: CGSize(width: screenSize.width/1.3, height: screenSize.height/1.5))
      
      self.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
      
      self.shuffle()
      self.drawCard()
      
    }
    
    
    ///--------------------------------------------------
    /// // MARK: Utility Methods
    ///--------------------------------------------------
    
    
    func updateDeckBackground() {
      
      var deckTexture:SKTexture
      
      do {
        
        let randomNumber = arc4random_uniform(UInt32(deckTextures.textureNames.count))
        deckTexture = deckTextures.textureNamed("Deck\(randomNumber)")
        
      } while deckTextures == self.texture
      
      self.texture = deckTexture
      
    }
    
    
    func shuffle() {
      
        for index in 1...deckSize{
          
          cards.append(index)

        }
      
        sort(&cards) {
          
          (_, _) in arc4random() % 2 == 0
          
        }
      
    }
    
    
    func drawCard() {
      
      let card = Card(cardValue: cards[0])
      card.size = self.size
      self.addChild(card)
      
    }
  
}