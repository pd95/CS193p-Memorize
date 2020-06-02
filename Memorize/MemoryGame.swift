//
//  MemoryGame.swift
//  Memorize
//
//  Created by Philipp on 20.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0
    private var seenCards = [Card]()
    private var firstCardTimestamp : TimeInterval = 0

    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                if cards[index].isFaceUp {
                    seenCards.append(cards[index])
                }
                cards[index].isFaceUp = index == newValue
            }
        }
    }

    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard, potentialMatchIndex != chosenIndex {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true

                    let currentCardTimestamp = Date().timeIntervalSinceReferenceDate
                    let multiplier = max(5 - (currentCardTimestamp - firstCardTimestamp), 1)
                    score += Int(2 * multiplier)
                }
                else {
                    score += seenCards.firstIndex(matching: cards[potentialMatchIndex]) != nil ? -1 : 0
                    score += seenCards.firstIndex(matching: cards[chosenIndex]) != nil ? -1 : 0
                }
                cards[chosenIndex].isFaceUp = true
            }
            else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                firstCardTimestamp = Date().timeIntervalSinceReferenceDate
            }
        }
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent

        var id = UUID()
    }
}
