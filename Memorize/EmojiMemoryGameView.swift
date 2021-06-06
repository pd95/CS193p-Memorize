//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Philipp on 27.05.21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            Text(game.themeName)
                .font(.title)

            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                }
                else {
                    CardView(card: card, color: game.color)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                Spacer()
                Button(action: game.newGame, label: {
                    Text("New Game")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                })
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(game.color)
                )
                Spacer()
            }
            .overlay(Text("Score:\n\(game.score)")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                     , alignment: .trailing)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
