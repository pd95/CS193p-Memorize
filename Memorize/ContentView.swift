//
//  ContentView.swift
//  Memorize
//
//  Created by Philipp on 27.05.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            Text(viewModel.themeName)
                .font(.title)

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.color)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                Spacer()
                Button(action: viewModel.newGame, label: {
                    Text("New Game")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                })
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(viewModel.color)
                )
                Spacer()
            }
            .overlay(Text("Score:\n\(viewModel.score)")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                     , alignment: .trailing)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let color: Color
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }
            else if card.isMatched {
                shape.opacity(0)
            }
            else {
                // Extra credit task: Use gradient to fill back of card
                shape.fill(LinearGradient(gradient: Gradient(colors: [color, .white]), startPoint: .top, endPoint: .bottom))
                shape.strokeBorder(lineWidth: 2)
            }
        }
        .foregroundColor(color)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
