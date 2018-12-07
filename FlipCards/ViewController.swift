//
//  ViewController.swift
//  FlipCards
//
//  Created by Mohammed Jacksi on 11/28/18.
//  Copyright © 2018 Mohammed Jacksi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count + 1) / 2
    }
    
    
    
    private lazy var currentTheme = emojiChoices[emojiChoices.count.arc4random]
    private var getRandomTheme:[String]{
        return emojiChoices[emojiChoices.count.arc4random]
    }
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func FlipCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            }else{
            print("Chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        updateViewFromModel()
        currentTheme = getRandomTheme
        emoji.removeAll(keepingCapacity: false)
            }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    private func updateViewFromModel(){
        scoreLabel.text = "\(game.gameScore)"
        countLabel.text = "\(game.flipCounter)"
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                //button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0):#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = [["🤸‍♀️","🎬","🏆","🤾‍♂️","🚑","⛲️","🕌","🎃"],["😀","😇","😭","😡","🤑","🎃","🙄","😍"],["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼"],["🍎","🍊","🍋","🍌","🍉","🍇","🍓","🍈"],["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱"],["🚦","🚥","🚗","🚓","🚑","🏎","🚀","🛩"]]
    private var emoji = [Int:String]()
    private func emoji(for card: Card)->String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let  randomIndex = currentTheme.count.arc4random
            emoji[card.identifier] = currentTheme.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int{
        if self > 0{
        return Int(arc4random_uniform(UInt32(UInt(self))))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(UInt(abs(self)))))
        }else{
            return 0
        }
        
    }
}
