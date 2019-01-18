//
//  SongDetailInteractorTests.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import MusicBrowser

class SongDetailInteractorTests: XCTestCase {
    
    private func setupEnvironment() -> (interactor: SongDetailInteractor, songPlayer: MockSongPlayer)? {
        guard let dataSource = MockGenerator.mockSongListDataSource else { return nil }
        let mockSongPlayer = MockSongPlayer()
        let mockInteractor = SongDetailInteractor(dataSource: dataSource, player: mockSongPlayer)
        return (interactor: mockInteractor, songPlayer: mockSongPlayer)
    }
    
    func testSkipSong() {
        guard let environment = setupEnvironment() else {
            XCTFail()
            return
        }
        
        let firstSong = environment.interactor.getCurrentSong()
        XCTAssertNotNil(environment.interactor.skipNextSong())
        XCTAssertNotEqual(firstSong.data.trackName, environment.interactor.getCurrentSong().data.trackName)
        
    }
    
    func testPlaySong() {
        guard let environment = setupEnvironment() else {
            XCTFail()
            return
        }
        
        XCTAssertFalse(environment.songPlayer.isPlaying)
        
        environment.interactor.playSong()
        XCTAssertTrue(environment.songPlayer.isPlaying)
        XCTAssertNotNil(environment.interactor.skipNextSong())
        XCTAssertTrue(environment.songPlayer.isPlaying)
        environment.interactor.playSong()
        XCTAssertFalse(environment.songPlayer.isPlaying)
        XCTAssertNotNil(environment.interactor.skipNextSong())
        XCTAssertFalse(environment.songPlayer.isPlaying)
    }

}


