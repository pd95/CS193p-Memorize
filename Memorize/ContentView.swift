//
//  ContentView.swift
//  Memorize
//
//  Created by Philipp on 27.05.21.
//

import SwiftUI

struct Theme {
    let name: String
    let symbolName: String
    let emojis: [String]

    static let allThemes: [Theme] = [
        Theme(name: "Vehicles", symbolName: "car", emojis: [
            "🚲","🚂","🚁","🚜","🏎","🚑","🚓","🚒","✈️","🚀","⛵",
            "🛸","🚌","🏍","🛺","🚠","🛵","🚗","🚚","🚇","🛻","🚝"
        ]),
        Theme(name: "Sports", symbolName: "sportscourt", emojis: [
            "⚽️","🏀","🏈","⚾️","🏓","🏏","🥊","🏉","🎾","🏒","🏌️‍♂️",
            "🏇🏻","🏄‍♂️","🚴‍♀️","🏊‍♂️"
        ]),
        Theme(name: "Faces", symbolName: "face.smiling", emojis: [
            "😃","😆","😇","🥰","🤪","🥳","😢","🥸","🤯","😱","🥶",
            "🥵","🧐","😋","😉","😂"
        ])
    ]
}

struct ContentView: View {
    
    @State private var theme = Theme.allThemes.first!
    
    @State private var emojis = [String]()
    @State private var emojiCount = 0
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .font(.largeTitle)
            .foregroundColor(.red)
            Spacer()
            HStack {
                themeButtons
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .onAppear() {
            setTheme(theme)
        }
    }
    
    func setTheme(_ theme: Theme) {
        self.emojis = theme.emojis.shuffled()
        self.theme = theme
        self.emojiCount = Int.random(in: 4...theme.emojis.count)
    }
    
    var themeButtons: some View {
        ForEach(Theme.allThemes, id: \.name) { theme in
            Button(action: {
                setTheme(theme)
            }, label: {
                VStack {
                    Image(systemName: theme.symbolName)
                        .imageScale(.large)
                        .font(.largeTitle)
                    Text(theme.name)
                }
                .frame(minWidth: 40, minHeight: 40)
            })
            .frame(maxWidth: .infinity)
        }
    }
}


struct CardView: View {
    var content: String
    
    @State private var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
