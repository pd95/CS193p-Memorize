//
//  CardView.swift
//  Memorize
//
//  Created by Philipp on 06.06.21.
//

import SwiftUI

struct CardView: View {
    let card: EmojiMemoryGame.Card
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                }
                else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    // Extra credit task: Use gradient to fill back of card
                    shape.fill(LinearGradient(gradient: Gradient(colors: [color, .white]), startPoint: .top, endPoint: .bottom))
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                }
            }
            .foregroundColor(color)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: .init(isFaceUp: false, isMatched: false, alreadyBeenSeen: false, content: "🤪", id: 1), color: .red)

            CardView(card: .init(isFaceUp: true, isMatched: false, alreadyBeenSeen: false, content: "🤪", id: 2), color: .red)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .frame(maxWidth: 150)
        .previewLayout(.sizeThatFits)
    }
}
