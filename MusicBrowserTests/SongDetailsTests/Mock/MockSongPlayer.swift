//
//  MockSongPlayer.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation
@testable import MusicBrowser

final class MockSongPlayer: SongPlayerProtocol {
    var mockPlaying: Bool = false
    var isPlaying: Bool {
        return mockPlaying
    }
    var delegate: SongPlayerDelegate?
    
    
    func play() {
        mockPlaying = true
    }
    
    func pause() {
        mockPlaying = false
    }
    
    func setup(with url: URL) {
        mockPlaying = false
    }
    
    
}
