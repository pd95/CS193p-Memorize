//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Philipp on 26.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching item: Element) -> Int? {
        if let index = self.firstIndex(where: {item.id == $0.id}) {
            return index
        }
        return nil
    }
}
