//
//  MemorizeExtensions.swift
//  Memorize
//
//  Created by Philipp on 10.06.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import Foundation
import SwiftUI

extension Array where Element: Identifiable {
    // find the index of the first element matching the ID of the given item
    func firstIndex(matching item: Element) -> Int? {
        if let index = self.firstIndex(where: {item.id == $0.id}) {
            return index
        }
        return nil
    }
}

extension Array {
    // return the one and only element or nil
    var only: Element? {
        count == 1 ? first : nil
    }
}

extension Data {
    // just a simple converter from a Data to a String
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}

extension Color {
    // Construct a Color
    init(_ rgb: UIColor.RGB) {
        self.init(UIColor(rgb))
    }
}

extension UIColor {
    // Codable struct to store the RGBA color values
    public struct RGB: Hashable, Codable {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
    }

    // Initializer to create a UIColor based on the struct
    convenience init(_ rgb: RGB) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
    }

    // computed variable returning the RGBA structure representing the current color
    public var rgb: RGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return RGB(red: red, green: green, blue: blue, alpha: alpha)
    }
}
