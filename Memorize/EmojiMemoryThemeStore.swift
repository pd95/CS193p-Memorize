//
//  EmojiMemoryThemeStore.swift
//  Memorize
//
//  Created by Philipp on 16.06.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import UIKit
import Combine

class EmojiMemoryThemeStore: ObservableObject {

    private var autosave: AnyCancellable?
    @Published var themes: [EmojiMemoryTheme]

    init() {
        let defaultsKey = "EmojiMemoryThemeStore"
        themes = (UserDefaults.standard.object(forKey: defaultsKey) as? [Data])?
            .compactMap({ EmojiMemoryTheme(json: $0) }) ?? EmojiMemoryTheme.themes
        autosave = $themes.sink { themes in
            UserDefaults.standard.set(themes.map{$0.json}, forKey: defaultsKey)
        }
    }

    // MARK: - Intents
    func updateTheme(for theme: EmojiMemoryTheme, name: String, emoji: [String], colorRGB: UIColor.RGB, numberOfPairs: Int) {
        let newTheme = EmojiMemoryTheme(name: name, emoji: emoji, colorRGB: colorRGB, numberOfPairs: numberOfPairs)
        if let index = themes.firstIndex(matching: theme) {
            themes[index] = newTheme
        }
    }
}

