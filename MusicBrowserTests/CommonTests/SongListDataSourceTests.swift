//
//  SongListDataSourceTests.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import MusicBrowser

class SongListDataSourceTests: XCTestCase {
    

    func testInitFail() {
        let datasource = SongListDataSource(songs: [MockGenerator.createMockSongData(name: "Track 1")], selectedIndex: 1)
        XCTAssertNil(datasource)
    }
    
    func testSkipPrevFirstSong() {
        guard let datasource = SongListDataSource(songs: [MockGenerator.createMockSongData(name: "Track 1"), MockGenerator.createMockSongData(name: "Track 2")], selectedIndex: 0) else {
            XCTFail()
            return
        }
        let currentSong = datasource.selectedSong
        XCTAssertNil(datasource.previous)
        datasource.skipPrevious()
        XCTAssertEqual(currentSong.trackName, datasource.selectedSong.trackName)
        
    }
    
    func testSkipNextSong() {
        guard let datasource = SongListDataSource(songs: [MockGenerator.createMockSongData(name: "Track 1"), MockGenerator.createMockSongData(name: "Track 2")], selectedIndex: 0) else {
            XCTFail()
            return
        }
        let currentSong = datasource.selectedSong
        XCTAssertNil(datasource.previous)
        XCTAssertNotNil(datasource.next)
        datasource.skipNext()
        XCTAssertNotEqual(currentSong.trackName, datasource.selectedSong.trackName)
    }
    
    func testSkipNextLastSong() {
        guard let datasource = SongListDataSource(songs: [MockGenerator.createMockSongData(name: "Track 1"), MockGenerator.createMockSongData(name: "Track 2")], selectedIndex: 1) else {
            XCTFail()
            return
        }
        let currentSong = datasource.selectedSong
        XCTAssertNil(datasource.next)
        datasource.skipNext()
        XCTAssertEqual(currentSong.trackName, datasource.selectedSong.trackName)
    }

}
