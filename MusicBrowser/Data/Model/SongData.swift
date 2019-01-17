//
//  SongData.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

struct SongData: Decodable {
    let trackName: String
    let artistName: String
    let collectionName: String?
    let previewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let releaseDate: String
    let trackPrice: Double
    let primaryGenreName: String
    let trackTimeMillis: TimeInterval
}
