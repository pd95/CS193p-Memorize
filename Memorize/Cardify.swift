//
//  Cardify.swift
//  Memorize
//
//  Created by Philipp on 02.06.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool

    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            }
            else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.1), Color.accentColor]),
                                         startPoint: .bottom, endPoint: .top))
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: 1)
            }
        }
    }

    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
