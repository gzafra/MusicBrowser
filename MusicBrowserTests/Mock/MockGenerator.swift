//
//  MockGenerator.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation
@testable import MusicBrowser

class MockGenerator {
    static var mockSongListDataSource: SongListDataSource? {
        return SongListDataSource(songs:
            [
                createMockSongData(name: "Track 1"),
                createMockSongData(name: "Track 2"),
                createMockSongData(name: "Track 3")
            ], selectedIndex: 0)
    }
    
    static func createMockSongData(name: String) -> SongData {
        let data = SongData(trackName: name,
                            artistName: "Artistname",
                            collectionName: "Collection",
                            previewUrl: "", artworkUrl60: "",
                            artworkUrl100: "",
                            releaseDate: "",
                            trackPrice: 9.99,
                            primaryGenreName: "Genre",
                            trackTimeMillis: 5234234)
        return data
    }
}
