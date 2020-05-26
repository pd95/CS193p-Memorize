//
//  MemoryGame.swift
//  Memorize
//
//  Created by Philipp on 20.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]

    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }

    func index(of card: Card) -> Int {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            return index
        }
        return 0 // TODO Bogus return value
        //fatalError("Cannot find card \(card)")
    }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }

    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent

        var id = UUID()
    }
}
