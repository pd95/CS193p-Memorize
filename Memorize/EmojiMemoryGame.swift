//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Philipp on 20.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct EmojiMemoryTheme {
    let name: String
    let emoji: [String]
    let color: Color
    let numberOfPairs: Int?

    static var themes: [EmojiMemoryTheme] = [
        EmojiMemoryTheme(name: "Animals", emoji: ["🐶","🐯","🐱","🐭","🦊","🐻","🐼","🐷","🐨","🐵","🦁", "🐔"], color: .blue, numberOfPairs: nil),
        EmojiMemoryTheme(name: "Halloween", emoji: ["👻","🎃","🧟","🕷","🕸", "🦇", "🪓", "🔪", "⛓", "⚰️"], color: .orange, numberOfPairs: nil),
        EmojiMemoryTheme(name: "Suites", emoji: ["♠️","♣️","♥️","♦️"], color: .gray, numberOfPairs: 4),
        EmojiMemoryTheme(name: "Sport", emoji: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱", "🏉", "🏓", "🥎", "🥇", "🏆"], color: .red, numberOfPairs: nil),
        EmojiMemoryTheme(name: "Food", emoji: ["🍏","🍎","🍊","🍋","🍌","🥑","🥝","🍇","🍐","🍓","🍒","🍉"], color: .blue, numberOfPairs: nil),
        EmojiMemoryTheme(name: "Vehicles", emoji: ["🚕","🚌","🚓","🚑","🚒","🚜","🚚","🚛","🚠","🚋","🚄","✈️","🛳","🚁","🚂"], color: .purple, numberOfPairs: nil),
        EmojiMemoryTheme(name: "Faces", emoji: ["😃","😂","😍","🙃","😇","😎","🤓","🤩",
                                                "🤬","🥶","🤢","🤠","😷","🤕","😱","😜",
                                                "🥵","🤡","💩","🥳"],
                         color: .pink, numberOfPairs: nil),
    ]
}

class EmojiMemoryGame: ObservableObject {

    @Published private var model: MemoryGame<String>
    private(set) var theme: EmojiMemoryTheme = EmojiMemoryTheme.themes.first!

    private func randomGame() -> (EmojiMemoryTheme, MemoryGame<String>) {
        let theme = EmojiMemoryTheme.themes.randomElement()!
        let emoji = theme.emoji.shuffled()
        let numberOfPairs: Int = theme.numberOfPairs ?? (4...emoji.count).randomElement()!
        let model = MemoryGame(numberOfPairsOfCards: numberOfPairs) { emoji[$0] }
        return (theme, model)
    }

    init() {
        let emoji = theme.emoji.shuffled()
        model = MemoryGame(numberOfPairsOfCards: 4) { emoji[$0] }
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
        let oldThemeName = theme.name
        repeat {
            theme = EmojiMemoryTheme.themes.randomElement()!
        } while theme.name == oldThemeName
        let emoji = theme.emoji.shuffled()
        let numberOfPairs: Int = theme.numberOfPairs ?? (2...emoji.count).randomElement()!
        model = MemoryGame(numberOfPairsOfCards: numberOfPairs) { emoji[$0] }
    }
}
