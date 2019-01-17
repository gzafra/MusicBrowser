//
//  SortOption.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

enum SortMode: Int {
    case length
    case genre
    case price
}

struct SortOption {
    let mode: SortMode
    let inverted: Bool
}
