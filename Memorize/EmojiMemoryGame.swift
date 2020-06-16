//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Philipp on 20.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    @Published private var model: MemoryGame<String>
    private(set) var theme: EmojiMemoryTheme

    init(theme: EmojiMemoryTheme? = nil) {
        self.theme = theme ?? EmojiMemoryTheme.themes.randomElement()!
        let emoji = self.theme.emoji.shuffled()
        model = MemoryGame(numberOfPairsOfCards: self.theme.numberOfPairs) { emoji[$0] }
    }

    // MARK: - Access to the Model

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    var score: Int {
        model.score
    }

    // MARK: - Intent(s)

    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }

    func restart() {
        let emoji = theme.emoji.shuffled()
        let numberOfPairs: Int = theme.numberOfPairs
        model = MemoryGame(numberOfPairsOfCards: numberOfPairs) { emoji[$0] }
    }
}
