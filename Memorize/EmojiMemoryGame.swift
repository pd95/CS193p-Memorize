//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Philipp on 20.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    private(set) var numberOfPairs: Int = 0

    static func createMemoryGame() -> MemoryGame<String> {
        let emoji: [String] = ["👻","🎃","😎","🤡","🙈","🌞","⚽️","🔨","😈","🧟","🕷","🕸"].shuffled()
        let numberOfPairs = (2...5).randomElement()!
        return MemoryGame(numberOfPairsOfCards: numberOfPairs) { emoji[$0] }
    }

    // MARK: - Access to the Model

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    // MARK: - Intent(s)

    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
