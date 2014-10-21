//
//  Contants.swift
//  Kings Cup
//
//  Created by Bruce Rick on 2014-10-21.
//  Copyright (c) 2014 Bruce Rick. All rights reserved.
//

import Foundation
import SpriteKit

let screenSize = UIScreen.mainScreen().bounds.size

let deckTextures = SKTextureAtlas(named: "Deck.atlas")
let deckSize = 52

let cardBackTexture = SKTexture(imageNamed: "Card")
let cardFrontTextures = SKTextureAtlas(named: "CardFrontTextures.atlas")