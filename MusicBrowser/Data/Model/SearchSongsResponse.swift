//
//  SearchSongsResponse.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

// TODO: It would be useful to create a custom decoder for the response so as to skip items that failed to parse.

struct SearchSongsResponse: Decodable {
    let results: [SongData]
    let resultCount: Int
}
