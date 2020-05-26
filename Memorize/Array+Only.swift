//
//  Array+Only.swift
//  Memorize
//
//  Created by Philipp on 26.05.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
