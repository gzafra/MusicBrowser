//
//  BrowseSongsViewModel.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

struct BrowseSongsViewModel {
    let numberOfSections: Int = 1
    var numberOfRows: Int {
        return songs.count
    }
    let songs: [SongViewModel]
}

struct SongViewModel {
    
    let title: String
    let artist: String
    let albumTitle: String
    let releaseDate: String
    let coverThumbnailUrl: String
    let songLength: String
    let genre: String
    let price: String
}
