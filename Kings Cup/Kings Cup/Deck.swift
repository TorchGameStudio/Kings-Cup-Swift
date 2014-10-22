//
//  Deck.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-17.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import Foundation
import SpriteKit

class Deck :UIImageView {
  
    required init(coder aDecoder: NSCoder) {
      
        fatalError("init(coder:) has not been implemented")
      
    }
    
    
    ///--------------------------------------------------
    /// // MARK: Variables
    ///--------------------------------------------------
    
    var cards :[Int] = []
    var cardView = UIView()
    var backCardView = UIImageView()
    var frontCardView = UIImageView()
    var cardDrawn = false
  
    ///--------------------------------------------------
    /// // MARK: Init Methods
    ///--------------------------------------------------
    
    
    override init() {
    
        super.init(frame: CGRect(x:  screenSize.width/2 - cardSize.width/2, y: screenSize.height/2 - cardSize.height/2, width: cardSize.width, height: cardSize.height))
      
        self.image = UIImage(named: "Deck/Deck1")
        self.userInteractionEnabled = true;
      
        cardView.contentMode = UIViewContentMode.ScaleAspectFit
        backCardView.contentMode = UIViewContentMode.ScaleAspectFit
        frontCardView.contentMode = UIViewContentMode.ScaleAspectFit
      
        addNotificationObservers()
        shuffle()
        drawCard()
  
    }
  
    ///--------------------------------------------------
    /// // MARK: Notification Methods
    ///--------------------------------------------------
    
    func addNotificationObservers() {
      
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "drawCard", name: CardFlippedNotification, object: nil)
      
    }
  
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
      
      if !cardDrawn {
        
        flipCard()
        
      } else {
        
        updateDeckBackground()
        drawCard()
        cardDrawn = false
        
      }
      
    }
  
    ///--------------------------------------------------
    /// // MARK: Utility Methods
    ///--------------------------------------------------
  
    func updateDeckBackground() {
        var deckImage:UIImage
        
        do {
          
            let randomNumber = arc4random_uniform(UInt32(deckImages - 1))
            deckImage = UIImage(named: "Deck/Deck\(randomNumber + 1)")
          
        } while deckImage == self.image
      
        self.image = deckImage
    }
    
    
    func shuffle() {
      
        for index in 1...deckSize {
          
            cards.append(index)

        }
      
        sort(&cards) {
          
            (_, _) in arc4random() % 2 == 0
          
        }
      
    }
  
    func drawCard() {
      
        frontCardView.removeFromSuperview()
        backCardView.removeFromSuperview()
        cardView.removeFromSuperview()
      
        frontCardView = UIImageView(frame: CGRect(x: 0, y: 0, width: cardSize.width, height: cardSize.height))
        backCardView = UIImageView(frame: CGRect(x: 0, y: 0, width: cardSize.width, height: cardSize.height))
        cardView = UIView(frame: CGRect(x: 0, y: 0, width: cardSize.width, height: cardSize.height))
        
        cardView.contentMode = UIViewContentMode.ScaleAspectFit
        cardView.addSubview(backCardView)
        self.addSubview(cardView)
        
        backCardView.image = UIImage(named: "Card")
        frontCardView.image = UIImage(named: "CardFront")
      
    }
  
  
    func flipCard() {
      
        let enlargedCardSize = CGSize(width: cardSize.width * CGFloat(1.25), height: cardSize.height * CGFloat(1.25))
        
        self.cardView.setFrameHeight(enlargedCardSize.height)
        self.cardView.setFrameWidth(enlargedCardSize.width)
        self.frontCardView.setFrameHeight(enlargedCardSize.height)
        self.frontCardView.setFrameWidth(enlargedCardSize.width)
        
        UIView.animateWithDuration(0.2, animations: {
          
            self.backCardView.setFrameHeight(enlargedCardSize.height)
            self.backCardView.setFrameWidth(enlargedCardSize.width)
          
            self.cardView.setFrameX(self.cardView.frame.origin.x - ((enlargedCardSize.width - cardSize.width)/2))
            self.cardView.setFrameY(self.cardView.frame.origin.y - ((enlargedCardSize.height - cardSize.height)/2))
          
        }, completion: { finished in
          
            UIView.transitionFromView(self.backCardView, toView: self.frontCardView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: { finished in
              
              self.cardDrawn = true
              
            })
            
        })
      
    }
  
}