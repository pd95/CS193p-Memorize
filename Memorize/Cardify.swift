//
//  Cardify.swift
//  Memorize
//
//  Created by Philipp on 02.06.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double

    var isFaceUp: Bool {
        rotation < 90
    }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)

            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.1), Color.accentColor]),
                                         startPoint: .bottom, endPoint: .top))
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: 1)
            }
            .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }

    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
