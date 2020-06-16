//
//  Grid.swift
//  Memorize
//
//  Created by Philipp on 26.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView, ID>: View where ID: Hashable, ItemView: View {
    private var items: [Item]
    private var id: KeyPath<Item, ID>
    private var viewForItem: (Item) -> ItemView

    init(_ items: [Item], id: KeyPath<Item,ID>, viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.id = id
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { proxy in
            self.body(for: GridLayout(itemCount: self.items.count, in: proxy.size))
        }
    }

    private func body(for layout: GridLayout) -> some View{
        ForEach(items, id: id) { item in
            self.body(for: item, in: layout)
        }
    }

    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(where: { item[keyPath: id] == $0[keyPath: id] })!
        return viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
    }
}

extension Grid where Item: Identifiable, ID == Item.ID {
    init(_ items: [Item], viewForItems: @escaping (Item) -> ItemView) {
        self.init(items, id: \Item.id, viewForItem: viewForItems)
    }
}
