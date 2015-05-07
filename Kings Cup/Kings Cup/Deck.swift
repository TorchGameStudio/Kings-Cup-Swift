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
  
  
///--------------------------------------------------
///
/// // MARK: - Variables
///
///--------------------------------------------------
  
  
    var cards :[Int] = []
  
    var cardView = UIView()
    var backCardView = UIImageView()
    var frontCardView = UIImageView()
  
    var rulesOverlayView = UIView()
    var ruleNameLabel = UILabel()
  
    typealias CardDrawnBlock = Void -> ()
    var cardDrawnBlock:CardDrawnBlock = {}
  
  
///--------------------------------------------------
///
/// // MARK: - Init Methods
///
///--------------------------------------------------
  

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.userInteractionEnabled = true
  
    }
  
  
///--------------------------------------------------
///
/// // MARK: - Utility Methods
///
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
  
    func discardDrawnCard() {
        cards.removeAtIndex(0)
        
        if cards.count == 0 {
          shuffle()
        }
    }
  
    func addNewCard() {
      
        updateDeckBackground()
      
        frontCardView.removeFromSuperview()
        backCardView.removeFromSuperview()
        cardView.removeFromSuperview()
      
        frontCardView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        backCardView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        cardView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
      
        cardView.contentMode = UIViewContentMode.ScaleAspectFit
        frontCardView.contentMode = UIViewContentMode.ScaleAspectFit
        backCardView.contentMode = UIViewContentMode.ScaleAspectFit
      
        cardView.addSubview(backCardView)
        self.addSubview(cardView)
        self.bringSubviewToFront(rulesOverlayView)
      
        backCardView.image = UIImage(named: "Card")
        frontCardView.image = UIImage(named: "Cards/\(cards[0])")
    }
  
    func drawCard() {
      
        let enlargedCardSize = CGSize(width: self.frame.width * CGFloat(1.25), height: self.frame.height * CGFloat(1.25))
        
        self.cardView.setFrameHeight(enlargedCardSize.height)
        self.cardView.setFrameWidth(enlargedCardSize.width)
        self.frontCardView.setFrameHeight(enlargedCardSize.height)
        self.frontCardView.setFrameWidth(enlargedCardSize.width)
        
        UIView.animateWithDuration(0.2, animations: {
          
            self.backCardView.setFrameHeight(enlargedCardSize.height)
            self.backCardView.setFrameWidth(enlargedCardSize.width)
          
            self.cardView.setFrameX(screenSize.width/2 - enlargedCardSize.width/2 - self.frame.origin.x)
            self.cardView.setFrameY(screenSize.height/2 - enlargedCardSize.height/2 - self.frame.origin.y)
          
          }, completion: { finished in
            
              self.flipCard()
            
        })
      
    }
  
    func flipCard() {
    
        UIView.transitionFromView(self.backCardView, toView: self.frontCardView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: { finished in
          
            self.cardDrawnBlock()
          
        })
    }
  
    class func suitWithValueForCardValue(value:Int) ->NSString {
      
        //♥ ♦ ♣ ♠
        
        var suit = (value-1) / cardsPerSuit
        var cardValueAndSuit = ""
        
        switch suit {
        case Suits.Spades.hashValue:
          cardValueAndSuit += "♠"
          break
        case Suits.Clubs.hashValue:
          cardValueAndSuit += "♣"
          break
        case Suits.Hearts.hashValue:
          cardValueAndSuit += "♥"
          break
        case Suits.Diamonds.hashValue:
          cardValueAndSuit += "♦"
          break
        default:
          break
        }
        
        var cardValue = value % cardsPerSuit
        
        switch cardValue {
        case 0:
          cardValueAndSuit += "K"
          break
        case 1:
          cardValueAndSuit += "A"
          break
        case 11:
          cardValueAndSuit += "J"
          break
        case 12:
          cardValueAndSuit += "Q"
          break
        default:
          cardValueAndSuit += "\(cardValue)"
          
        }
        
        
        return cardValueAndSuit
      
    }
  
}