//
//  MemoryGame.swift
//  Memorize
//
//  Created by Philipp on 27.05.21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0

    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private var timeSinceChoosingCard: Date?

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard,
               let timeSinceChoosingCard = timeSinceChoosingCard {

                // Extra credit task 4: capture tap duration and calculate speed factor
                let distance = Int(timeSinceChoosingCard.distance(to: Date()))
                let speedFactor = max(10 - distance, 1)

                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    score += speedFactor * 2
                }
                else {
                    if cards[chosenIndex].alreadyBeenSeen {
                        score -= speedFactor * 1
                    }
                    if cards[potentialMatchIndex].alreadyBeenSeen {
                        score -= speedFactor * 1
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }
            else {
                for index in cards.indices {
                    if cards[index].isFaceUp {
                        cards[index].alreadyBeenSeen = true
                    }
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                timeSinceChoosingCard = Date()
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        let content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var alreadyBeenSeen: Bool = false
        let id: Int
    }
}