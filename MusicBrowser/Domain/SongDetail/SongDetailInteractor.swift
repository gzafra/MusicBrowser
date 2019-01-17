//
//  SongDetailInteractor.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

enum SongState {
    case playing
    case paused
}

typealias CurrentSongData = (data: SongData, state: SongState, next: SongData?, prev: SongData?)

class SongDetailInteractor: SongDetailInteractorProtocol {

    private let dataSource: SongListDataSource
    private var player: AVPlayer? = nil
    private var state: SongState = .paused {
        didSet{
            delegate?.didChangeState(state)
        }
    }
    
    weak var delegate: SongDetailInteractorDelegate?
    
    init(dataSource: SongListDataSource) {
        self.dataSource = dataSource
    }
    
    func getCurrentSong() -> CurrentSongData {
        return (data: dataSource.selectedSong, state: state, next: dataSource.next, prev: dataSource.previous)
    }

    
    func skipNextSong() -> CurrentSongData? {
        dataSource.skipNext()
        if state == .playing {
            pauseSong()
            loadSong()
        }
        return (data: dataSource.selectedSong, state: state, next: dataSource.next, prev: dataSource.previous)
    }
    
    func skipPreviousSong() -> CurrentSongData? {
        dataSource.skipPrevious()
        if state == .playing {
            pauseSong()
            loadSong()
        }
        return (data: dataSource.selectedSong, state: state, next: dataSource.next, prev: dataSource.previous)
    }
    
    /// Loads a new AudioPlayer with the current song and automatically plays
    private func loadSong() {
        let song = getCurrentSong()
        guard let url = URL(string: song.data.previewUrl) else { return }
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        
        NotificationCenter.default.addObserver(self, selector: #selector(finishVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        state = .playing
    }

    
    @objc func finishVideo() {
        state = .paused
    }
    
    /// Stops currently playing song
    private func pauseSong() {
        player?.pause()
        state = .paused
    }
    
    /// Plays / Pauses the current loaded song or loads one if nothing is playing
    func playSong() {
        if let player = player {
            if player.timeControlStatus == .playing {
                pauseSong()
            }else{
                player.play()
                state = .playing
            }
        }else{
            loadSong()
        }
        
    }
}
