//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Philipp on 19.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            header

            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .padding(5)
                    .onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            }
            .padding()
            .foregroundColor(viewModel.theme.color)

            restartButton
        }
        .accentColor(viewModel.theme.color)
        .padding()
    }

    private var header: some View {
        HStack {
            Text(viewModel.theme.name)
                .font(.largeTitle)
                .padding()

            Spacer()
            Text("\(viewModel.score)")
        }
    }

    private var restartButton: some View {
        Button(action: restart) {
            Text("New Game")
                .font(.headline)
                .padding()
                .foregroundColor(Color.white)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(viewModel.theme.color))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1))
                .shadow(radius: 5)
        }
    }

    private func restart() {
        viewModel.restart()
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { proxy in
            self.body(for: proxy.size)
        }
    }

    private func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            }
            else {
                if !self.card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.1), Color.accentColor]),
                                             startPoint: .bottom, endPoint: .top))
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: 1)
                }
            }
        }
        .font(fontSize(for: size))
    }

    // MARK: - Drawing Constants

    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private func fontSize(for size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * 0.75)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
