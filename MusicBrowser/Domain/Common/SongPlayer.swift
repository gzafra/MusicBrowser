//
//  SongPlayer.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

protocol SongPlayerProtocol {
    var isPlaying: Bool { get }
    var delegate: SongPlayerDelegate? { get set }
    
    func play()
    func pause()
    func setup(with url: URL)
}

protocol SongPlayerDelegate: class {
    func didFinishPlaying()
}

class SongPlayer: SongPlayerProtocol {
    private var player: AVPlayer? = nil // TODO: This should be a shared session for the app instead of a single player
    weak var delegate: SongPlayerDelegate?
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func setup(with url: URL) {
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        
        NotificationCenter.default.addObserver(self, selector: #selector(finishedPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        player = AVPlayer(playerItem: playerItem)
    }
    
    var isPlaying: Bool {
        return player?.timeControlStatus == .playing
    }
    
    @objc func finishedPlaying() {
        delegate?.didFinishPlaying()
    }
    
}
