//
//  Theme.swift
//  Memorize
//
//  Created by Philipp on 27.05.21.
//

import Foundation

struct Theme {
    enum PlayMode {
        case fixed(Int)
        case random
        case all
    }
    
    let name: String
    let symbolName: String
    let emojis: [String]
    let color: String
    let mode: PlayMode
    
    var numberOfPairs: Int {
        switch mode {
        case .fixed(let value):
            return value
        case .random:
            return Int.random(in: 1...emojis.count)
        case .all:
            return emojis.count
        }
    }
    
    
    init(name: String, symbolName: String, emojis: [String], color: String, numberOfPairs: Int) {
        self.init(name: name, symbolName: symbolName, emojis: emojis, color: color, mode: .fixed(numberOfPairs))
    }

    // Extra credit task 1 and 2: allow specifying a mode taking _all_ or a random number of emojis
    init(name: String, symbolName: String, emojis: [String], color: String, mode: PlayMode) {
        self.name = name
        self.symbolName = symbolName
        self.emojis = emojis
        self.color = color
        self.mode = mode
    }
    

    static let vehicles = Theme(name: "Vehicles", symbolName: "car", emojis: [
        "🚲","🚂","🚁","🚜","🏎","🚑","🚓","🚒","✈️","🚀","⛵",
        "🛸","🚌","🏍","🛺","🚠","🛵","🚗","🚚","🚇","🛻","🚝"
    ], color: "pink", numberOfPairs: 8)
    static let sports = Theme(name: "Sports", symbolName: "sportscourt", emojis: [
        "⚽️","🏀","🏈","⚾️","🏓","🏏","🥊","🏉","🎾","🏒","🏌️‍♂️",
        "🏇🏻","🏄‍♂️","🚴‍♀️","🏊‍♂️"
    ], color: "yellow", mode: .random)
    static let faces = Theme(name: "Faces", symbolName: "face.smiling", emojis: [
        "😃","😆","😇","🥰","🤪","🥳","😢","🥸","🤯","😱","🥶",
        "🥵","🧐","😋","😉","😂"
    ], color: "red", numberOfPairs: 10)

    static let allThemes: [Theme] = [
        vehicles,
        sports,
        faces,
        Theme(name: "Halloween", symbolName: "wand.and.stars.inverse", emojis: ["👻","🎃","🕷","🕸","🧟"], color: "orange", mode: .all),
        Theme(name: "Things", symbolName: "hammer", emojis: ["🧶","🎩","🕶","🧵","👑", "👔", "👖", "💍", "🎧"], color: "blue", numberOfPairs: 6),
    ]
}

