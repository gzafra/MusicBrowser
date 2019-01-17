//
//  SongDetailViewModel.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

struct SongDetailViewModel {
    let songTitle: String
    let songArtist: String
    let coverURL: String
    let previewURL: String
    
    let hasNext: Bool
    let hasPrev: Bool
    let isPlaying: Bool
}
