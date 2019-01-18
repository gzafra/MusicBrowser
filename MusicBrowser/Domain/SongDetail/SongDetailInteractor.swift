//
//  SongDetailInteractor.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

enum SongState {
    case playing
    case paused
}

typealias CurrentSongData = (data: SongData, state: SongState, next: SongData?, prev: SongData?)

class SongDetailInteractor: SongDetailInteractorProtocol {

    private let dataSource: SongListDataSource
    private var player: SongPlayerProtocol
    private var state: SongState = .paused {
        didSet{
            delegate?.didChangeState(state)
        }
    }
    
    weak var delegate: SongDetailInteractorDelegate?
    
    init(dataSource: SongListDataSource, player: SongPlayerProtocol = SongPlayer()) {
        self.dataSource = dataSource
        self.player = player
        self.player.delegate = self
        loadSong()
    }
    
    func getCurrentSong() -> CurrentSongData {
        return (data: dataSource.selectedSong, state: state, next: dataSource.next, prev: dataSource.previous)
    }

    
    func skipNextSong() -> CurrentSongData? {
        dataSource.skipNext()
        if state == .playing {
            pauseSong()
            loadSong()
            playSong()
        }else{
            loadSong()
        }

        return (data: dataSource.selectedSong, state: state, next: dataSource.next, prev: dataSource.previous)
    }
    
    func skipPreviousSong() -> CurrentSongData? {
        dataSource.skipPrevious()
        if state == .playing {
            pauseSong()
            loadSong()
            playSong()
        }else{
            loadSong()
        }
        return (data: dataSource.selectedSong, state: state, next: dataSource.next, prev: dataSource.previous)
    }
    
    /// Plays / Pauses the current loaded song or loads one if nothing is playing
    func playSong() {
        if player.isPlaying { // TODO: NEed to know if a song is not loaded to setup
            pauseSong()
        }else{
            player.play()
            state = .playing
        }
        
    }
    
    func stopSong() {
        player.pause()
    }
    
    /// Loads a new AudioPlayer with the current song and automatically plays
    private func loadSong() {
        let song = getCurrentSong()
        guard let url = URL(string: song.data.previewUrl) else { return }
        
        player.setup(with: url)
    }
    
    /// Stops currently playing song
    private func pauseSong() {
        player.pause()
        state = .paused
    }
}

// MARK: - SongPlayerDelegate

extension SongDetailInteractor: SongPlayerDelegate {
    func didFinishPlaying() {
       state = .paused
    }
    
}
