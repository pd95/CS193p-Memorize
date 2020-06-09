//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Philipp on 20.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct EmojiMemoryTheme: Codable {
    let name: String
    let emoji: [String]
    let colorRGB: UIColor.RGB
    let numberOfPairs: Int

    var color: Color {
        Color(colorRGB)
    }

    var json: Data? {
        try? JSONEncoder().encode(self)
    }

    init(name: String, emoji: [String], colorRGB: UIColor.RGB, numberOfPairs: Int) {
        self.name = name
        self.emoji = emoji
        self.colorRGB = colorRGB
        self.numberOfPairs = numberOfPairs
    }

    init?(json: Data?) {
        if let json = json, let newEmojiTheme = try? JSONDecoder().decode(EmojiMemoryTheme.self, from: json) {
            self = newEmojiTheme
        }
        else {
            return nil
        }
    }

    static var themes: [EmojiMemoryTheme] = [
        EmojiMemoryTheme(name: "Animals", emoji: ["🐶","🐯","🐱","🐭","🦊","🐻","🐼","🐷","🐨","🐵","🦁", "🐔"], colorRGB: UIColor.blue.rgb, numberOfPairs: 12),
        EmojiMemoryTheme(name: "Halloween", emoji: ["👻","🎃","🧟","🕷","🕸", "🦇", "🪓", "🔪", "⛓", "⚰️"], colorRGB: UIColor.orange.rgb, numberOfPairs: 10),
        EmojiMemoryTheme(name: "Suites", emoji: ["♠️","♣️","♥️","♦️"], colorRGB: UIColor.gray.rgb, numberOfPairs: 4),
        EmojiMemoryTheme(name: "Sport", emoji: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱", "🏉", "🏓", "🥎", "🥇", "🏆"], colorRGB: UIColor.red.rgb, numberOfPairs: 12),
        EmojiMemoryTheme(name: "Food", emoji: ["🍏","🍎","🍊","🍋","🍌","🥑","🥝","🍇","🍐","🍓","🍒","🍉"], colorRGB: UIColor.blue.rgb, numberOfPairs: 12),
        EmojiMemoryTheme(name: "Vehicles", emoji: ["🚕","🚌","🚓","🚑","🚒","🚜","🚚","🚛","🚠","🚋","🚄","✈️","🛳","🚁","🚂"], colorRGB: UIColor.purple.rgb, numberOfPairs: 15),
        EmojiMemoryTheme(name: "Faces", emoji: ["😃","😂","😍","🙃","😇","😎","🤓","🤩",
                                                "🤬","🥶","🤢","🤠","😷","🤕","😱","😜",
                                                "🥵","🤡","💩","🥳"],
                         colorRGB: UIColor.systemPink.rgb, numberOfPairs: 20),
    ]
}

class EmojiMemoryGame: ObservableObject {

    @Published private var model: MemoryGame<String>
    private(set) var theme: EmojiMemoryTheme = EmojiMemoryTheme.themes.randomElement()!

    init() {
        let emoji = theme.emoji.shuffled()
        print(theme.json!.utf8!)
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
        let numberOfPairs: Int = theme.numberOfPairs
        print(theme.json!.utf8!)
        model = MemoryGame(numberOfPairsOfCards: numberOfPairs) { emoji[$0] }
    }
}
