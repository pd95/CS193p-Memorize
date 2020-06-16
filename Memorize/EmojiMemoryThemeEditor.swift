//
//  EmojiMemoryThemeEditor.swift
//  Memorize
//
//  Created by Philipp on 16.06.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct EmojiMemoryThemeEditor: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: EmojiMemoryThemeStore

    let theme: EmojiMemoryTheme

    @State private var name: String = ""
    @State private var emojis: [String] = ["❤️"]
    @State private var numberOfPairs: Int = 4
    @State private var color: UIColor = .brown
    @State private var addEmoji: String = ""

    var body: some View {
        NavigationView {
            Form {
                nameSection

                addEmojiSection

                emojisSection

                cardCountSection

                colorSection
            }
            .onAppear() {
                self.name = self.theme.name
                self.emojis = self.theme.emoji
                self.numberOfPairs = self.theme.numberOfPairs
                self.color = UIColor(self.theme.colorRGB)
            }
            .navigationBarTitle(Text(self.theme.name), displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: cancel, label: { Text("Cancel") }),
                trailing: Button(action: saveTheme, label: { Text("Done") })
                    .disabled(cannotSave)
            )
        }
    }

    var nameSection: some View {
        Section {
            TextField("Theme Name", text: $name)
        }
    }

    var addEmojiSection: some View {
        Section(header: Text("Add Emoji").font(.headline)) {
            HStack {
                TextField("Emoji", text: $addEmoji)
                Button(action: {
                    let newEmojis = self.addEmoji.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.emojis.insert(contentsOf: Set<String>(newEmojis.map{String($0)}), at: 0)
                    self.addEmoji = ""
                }) {
                    Text("Add")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }

    var emojisSection: some View {
        Section(header: HStack {
            Text("Emojis").font(.headline)
            Spacer()
            Text("tap emoji to exclude")
        }) {
            Grid(self.emojis, id: \.self, viewForItem: emojiItemView)
            .frame(height: self.emojiGridHeight)
        }
    }

    func emojiItemView(_ emoji: String) -> some View {
        Text(emoji)
            .font(Font.system(size: self.emojiGridFontSize))
            .onTapGesture {
                self.emojis.removeAll(where: { $0 == emoji })
                self.numberOfPairs = min(self.emojis.count, self.numberOfPairs)
        }
    }

    var cardCountSection: some View {
        Section(header: Text("Card Count").font(.headline)) {
            Stepper("\(numberOfPairs) pairs", value: $numberOfPairs, in: min(emojis.count, 2)...emojis.count)
                .disabled(emojis.count < 2)
        }
    }

    // List of available colors to choose from
    static let colorPatches: [UIColor] = [
        .label, .secondaryLabel, .systemGray3, .systemYellow, .systemOrange, .systemRed, .systemPink,
        .systemGreen, .systemTeal,.systemBlue,
        .systemIndigo,  .systemPurple,
    ]

    var colorSection: some View {
        Section(header: Text("Color").font(.headline)) {
            Grid(Self.colorPatches, id: \.self, viewForItem: colorItemView)
                .frame(height: self.colorGridHeight)
        }
    }

    // A color patch representing a color to choose.
    // The selection is shown using a filled checkmark symbol
    private func colorItemView(_ color: UIColor) -> some View {
        // determine "brightness" of the color to influence the checkmark color
        var brightness: CGFloat = .zero
        color.getWhite(&brightness, alpha: nil)

        return RoundedRectangle(cornerRadius: 4)
            .foregroundColor(Color(color))
            .padding(2)
            .overlay(Group {
                if color.rgb == self.color.rgb {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(brightness < 0.55 ? .white : .black)
                }
            })
            .onTapGesture {
                self.color = color
            }
    }

    // MARK: - Confirmation actions

    private var cannotSave: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        emojis.count < 2
    }

    private func saveTheme() {
        name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        store.updateTheme(for: theme, name: name, emoji: emojis, colorRGB: color.rgb, numberOfPairs: numberOfPairs)
        presentationMode.wrappedValue.dismiss()
    }

    private func cancel() {
        presentationMode.wrappedValue.dismiss()
    }

    // MARK: - Drawing Constants

    private let emojiGridFontSize: CGFloat = 40
    private var emojiGridHeight: CGFloat {
        CGFloat((emojis.count - 1 ) / 6 * 70 + 70)
    }

    private var colorGridHeight: CGFloat {
        CGFloat((Self.colorPatches.count - 1 ) / 5 * 70 + 70)
    }
}

struct EmojiMemoryThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryThemeEditor(theme: .template)
    }
}
