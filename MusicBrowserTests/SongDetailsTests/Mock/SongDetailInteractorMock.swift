//
//  SongDetailInteractorMock.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 18/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation
@testable import MusicBrowser

final class SongDetailInteractorMock: SongDetailInteractorProtocol {
    
    var delegate: SongDetailInteractorDelegate?
    var isPlaying: Bool = false
    
    
    func getCurrentSong() -> (data: SongData, state: SongState, next: SongData?, prev: SongData?) {
        return (data: MockGenerator.createMockSongData(name: "Track 1"), state: (isPlaying ? SongState.playing : SongState.paused), next: nil, prev: nil)
    }
    
    func skipNextSong() -> (data: SongData, state: SongState, next: SongData?, prev: SongData?)? {
        return (data: MockGenerator.createMockSongData(name: "Track 2"), state: (isPlaying ? SongState.playing : SongState.paused), next: nil, prev: nil)
    }
    
    func skipPreviousSong() -> (data: SongData, state: SongState, next: SongData?, prev: SongData?)? {
        return nil
    }
    
    func playSong() {
        isPlaying = !isPlaying
    }
    
    func stopSong() {
        isPlaying = false
    }
    
}
