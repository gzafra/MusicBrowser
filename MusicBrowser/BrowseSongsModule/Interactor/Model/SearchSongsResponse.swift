//
//  SearchSongsResponse.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

struct SearchSongsResponse: Decodable {
    let results: [SongData]
    let resultCount: Int
}
