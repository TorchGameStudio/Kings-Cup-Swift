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
    /// // MARK:
    /// // MARK: Variables
    /// // MARK:
    ///--------------------------------------------------
  
    var cards :[Int] = []
    var cardDrawn = false
  
    var cardView = UIView()
    var backCardView = UIImageView()
    var frontCardView = UIImageView()
  
    var rulesOverlayView = UIView()
    var ruleNameLabel = UILabel()
  
    ///--------------------------------------------------
    /// // MARK:
    /// // MARK: Init Methods
    /// // MARK:
    ///--------------------------------------------------
    
    
    override init() {
    
        super.init(frame: CGRect(x:  screenSize.width/2 - cardSize.width/2, y: screenSize.height/2 - cardSize.height/2, width: cardSize.width, height: cardSize.height))
      
        self.userInteractionEnabled = true;
      
        addNotificationObservers()
        initCards()
      
    }
  
    override func didMoveToSuperview() {
      //TODO potentially use this instead of overriding init
      super.didMoveToSuperview()
    }
  
    func initCards () {
      
        cardView.contentMode = UIViewContentMode.ScaleAspectFit
        backCardView.contentMode = UIViewContentMode.ScaleAspectFit
        frontCardView.contentMode = UIViewContentMode.ScaleAspectFit
        shuffle()
        addNewCard()
        initRulesOverlay()
      
    }
  
    func initRulesOverlay() {
      
        rulesOverlayView = UIView(frame: CGRect(x:screenSize.width/2 - rulesOverlaySize.width/2 - self.frame.origin.x,
                                                y: screenSize.height/2 - rulesOverlaySize.height/2 - self.frame.origin.y,
                                            width: rulesOverlaySize.width,
                                           height: rulesOverlaySize.height))
      
        rulesOverlayView.backgroundColor = UIColor.blackColor()
        rulesOverlayView.alpha = 0.0
      
        initRulesNameLabel()
      
        rulesOverlayView.addSubview(ruleNameLabel)
        self.addSubview(rulesOverlayView)
    }
  
    func initRulesNameLabel() {
      
        ruleNameLabel = UILabel(frame: CGRect(x: 0,
                                              y: 0,
                                          width: rulesOverlayView.frame.size.width,
                                         height: rulesOverlayView.frame.size.height))
      
        ruleNameLabel.text = "Rule name goes here"
        ruleNameLabel.textAlignment = NSTextAlignment.Center
        ruleNameLabel.font = UIFont.systemFontOfSize(ruleNameFontSize)
        ruleNameLabel.textColor = UIColor.whiteColor()
      
    }
  
    ///--------------------------------------------------
    /// // MARK:
    /// // MARK: Notification Methods
    /// // MARK:
    ///--------------------------------------------------
  
    func addNotificationObservers() {
      
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "drawCard", name: CardFlippedNotification, object: nil)
      
    }
  
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
      
      if !cardDrawn {
        
          drawCard()
        
      } else {
      
          animateRulesOverlay()
        
      }
      
    }
  
  
    ///--------------------------------------------------
    /// // MARK:
    /// // MARK: Utility Methods
    /// // MARK:
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
  
    func addNewCard() {
      
        cardDrawn = false
        updateDeckBackground()
      
        frontCardView.removeFromSuperview()
        backCardView.removeFromSuperview()
        cardView.removeFromSuperview()
      
        frontCardView = UIImageView(frame: CGRect(x: 0, y: 0, width: cardSize.width, height: cardSize.height))
        backCardView = UIImageView(frame: CGRect(x: 0, y: 0, width: cardSize.width, height: cardSize.height))
        cardView = UIView(frame: CGRect(x: 0, y: 0, width: cardSize.width, height: cardSize.height))
        
        cardView.contentMode = UIViewContentMode.ScaleAspectFit
        cardView.addSubview(backCardView)
        self.addSubview(cardView)
        self.bringSubviewToFront(rulesOverlayView)
        
        backCardView.image = UIImage(named: "Card")
        frontCardView.image = UIImage(named: "Cards/\(cards[0])")
        cards.removeAtIndex(0)
      
        if cards.count == 0 {
          
          shuffle()
          
        }
      
    }
  
  
  
  
    func drawCard() {
      
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
            
              self.flipCard()
            
        })
      
    }
  
    func flipCard() {
    
        UIView.transitionFromView(self.backCardView, toView: self.frontCardView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: { finished in
          
            self.animateRulesOverlay()
          
        })
    
    }
  
    func animateRulesOverlay() {
      
      let currentRulesOverlayAlpha = rulesOverlayView.alpha
      
      var targetAlpha:CGFloat
      
      if !self.cardDrawn {
        
          targetAlpha = rulesOverlayAlpha
          rulesOverlayView.alpha = 0
        
      } else {
        
          targetAlpha = 0
          rulesOverlayView.alpha = rulesOverlayAlpha
        
      }
      
      UIView.animateWithDuration(0.2, animations: {
        
          self.rulesOverlayView.alpha = targetAlpha
        
        }, completion: { finished in
          
            if self.cardDrawn {
              
                self.cardDrawn = false
                self.addNewCard()
              
            } else {
              
                self.cardDrawn = true
              
            }
          
      })
    
    }
  
    func animateContinueButton() {
      
      //
      
    }
  
}