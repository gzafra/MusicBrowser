//
//  SongDetailPresenter.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

enum SongControlButton {
    case play
    case next
    case prev
    case stop
}

class SongDetailPresenter: SongDetailPresenterProtocol {
    var interactor: SongDetailInteractorProtocol
    var viewInterface: SongDetailViewInterface?
    
    // MARK: - Lifecycle
    
    init(interactor: SongDetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        let songData = interactor.getCurrentSong()
        viewInterface?.viewShouldUpdate(with: generateViewModel(with: songData))
        
    }
    
    private func generateViewModel(with song: CurrentSongData) -> SongDetailViewModel {
        return SongDetailViewModel(songTitle: song.data.trackName,
                                   songArtist: song.data.artistName,
                                   coverURL: song.data.artworkUrl100,
                                   previewURL: song.data.previewUrl,
                                   hasNext: song.next != nil,
                                   hasPrev: song.prev != nil,
                                   isPlaying: song.state == .playing)
    }
    
    func didAction(button: SongControlButton) {
        switch button {
        case .next:
            guard let nextSong = interactor.skipNextSong() else { return }
            viewInterface?.viewShouldUpdate(with: generateViewModel(with: nextSong))
        case .prev:
            guard let prevSong = interactor.skipPreviousSong() else { return }
            viewInterface?.viewShouldUpdate(with: generateViewModel(with: prevSong))
        case .play:
            interactor.playSong()
            viewInterface?.viewShouldUpdate(with: generateViewModel(with: interactor.getCurrentSong()))
        case .stop:
            interactor.stopSong()
            viewInterface?.viewShouldUpdate(with: generateViewModel(with: interactor.getCurrentSong()))
        }
    }
    
    func getShareContent() -> String {
        let songData = interactor.getCurrentSong()
        return String(format: LocalizedStrings.SongDetails.shareContent, songData.data.trackName, songData.data.artistName)
    }
}

extension SongDetailPresenter: SongDetailInteractorDelegate {
    func didChangeState(_ songState: SongState) {
        viewInterface?.viewShouldUpdate(with: generateViewModel(with: interactor.getCurrentSong()))
    }
}
