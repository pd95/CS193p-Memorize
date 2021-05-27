//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Philipp on 27.05.21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberofPairs = min(theme.numberOfPairs, emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: numberofPairs) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    private var theme: Theme
    private(set) var color: Color

    init() {
        let startTheme = Theme.allThemes.first!
        theme = startTheme
        color = Color(name: startTheme.color) ?? .accentColor
        model = Self.createMemoryGame(theme: startTheme)
    }
    
    var score: Int {
        model.score
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var themeName: String {
        theme.name
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        let oldTheme = theme
        while theme.name == oldTheme.name {
            theme = Theme.allThemes.randomElement()!
        }
        color = Color(name: theme.color) ?? .accentColor
        model = Self.createMemoryGame(theme: theme)
    }
}


extension Color {
    // Helper to initialize a Color based on its name
    init?(name: String) {
        switch name {
        case "red":
            self = .red
        case "green":
            self = .green
        case "blue":
            self = .blue
        case "yellow":
            self = .yellow
        case "orange":
            self = .orange
        case "pink":
            self = .pink
        case "black":
            self = .black
        case "gray":
            self = .gray
        default:
            return nil
        }
    }
}
