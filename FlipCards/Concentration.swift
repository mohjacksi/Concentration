//
//  Concentration.swift
//  FlipCards
//
//  Created by Mohammed Jacksi on 12/5/18.
//  Copyright © 2018 Mohammed Jacksi. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    private(set) var gameScore = 0
    private(set) var flipCounter = 0
    private var indexOfOneOnlyAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int)
    {
        flipCounter += 1
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneOnlyAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                }else{
                    if cards[index].hasBeSeen{
                        gameScore -= 1
                    }
                    if cards[matchIndex].hasBeSeen{
                        gameScore -= 1
                    }
                    cards[index].hasBeSeen = true
                 
                }
                cards[index].isFaceUp = true
            }else{
                indexOfOneOnlyAndOnlyFaceUpCard = index
            }
            
        }
    }
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    
    func newGame(){
        gameScore = 0
        flipCounter = 0
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].hasBeSeen = false
        }
        cards.shuffle()
    }
}
