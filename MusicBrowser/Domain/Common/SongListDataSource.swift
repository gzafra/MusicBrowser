//
//  SongListDataSource.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class SongListDataSource {
    let songs: [SongData]
    private var selectedIndex: Int
    
    init?(songs: [SongData], selectedIndex: Int) {
        guard songs.count > 0, songs.indices.contains(selectedIndex) else { return nil }
        self.songs = songs
        self.selectedIndex = selectedIndex
    }
    
    var selectedSong: SongData {
        return songs[selectedIndex]
    }
    
    var next: SongData? {
        let nextIndex = selectedIndex+1
        guard songs.indices.contains(nextIndex) else { return nil }
        return selectedSong
    }
    
    var previous: SongData? {
        let prevIndex = selectedIndex-1
        guard songs.indices.contains(prevIndex) else { return nil }
        return selectedSong
    }
    
    func skipNext() {
        guard next != nil else { return }
        selectedIndex += 1
    }
    
    func skipPrevious() {
        guard previous != nil else { return }
        selectedIndex -= 1
    }
}
