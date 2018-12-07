//
//  Card.swift
//  FlipCards
//
//  Created by Mohammed Jacksi on 12/5/18.
//  Copyright © 2018 Mohammed Jacksi. All rights reserved.
//

import Foundation
/*
 The main diffrence between Class and Struct:
  1- No inherting in struct.
  2- Struct are value type!!, Class is refrence type
        when you pass struct to a function it's get copy,
        but class pass by refrence
 */
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    var hasBeSeen = false
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        identifier = Card.getUniqueIdentifier()
    }
}
