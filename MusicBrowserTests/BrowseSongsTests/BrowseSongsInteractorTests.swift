//
//  MusicBrowserTests.swift
//  MusicBrowserTests
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import XCTest
@testable import MusicBrowser

class MusicBrowserTests: XCTestCase {
    let mockRequestManager = MockRequestManager(promiseJson: MockRequestManagerPromises.iTunesSearch)
    
    func testSearchSuccess() {
        
        let interactor = BrowseSongsInteractor(requestManager: mockRequestManager)
        testExpectation(description: "Search songs", actionBlock: { (expectation) in
            interactor.seachSongs(with: [], successBlock: { (response) in
                expectation.fulfill()
            }, failureBlock: {
                XCTFail()
            })
        }, waitFor: 2.0)
        
    }
    
    func testSearchFailure() {
    
        mockRequestManager.shouldSucceed = false
        testExpectation(description: "Search songs", actionBlock: { (expectation) in
            let interactor = BrowseSongsInteractor(requestManager: mockRequestManager)
            interactor.seachSongs(with: [], successBlock: { (response) in
                XCTFail()
            }) {
                expectation.fulfill()
            }
        }, waitFor: 2.0)
    }
    
    func testGetSongList() {
        mockRequestManager.shouldSucceed = true
        testExpectation(description: "Search songs", actionBlock: { (expectation) in
            let interactor = BrowseSongsInteractor(requestManager: mockRequestManager)
            interactor.seachSongs(with: [], successBlock: { (response) in
                let songList = interactor.getSongList(with: 0)
                XCTAssertNotNil(songList)
                XCTAssert(songList!.songs.count > 0)
                expectation.fulfill()
            }) {
                XCTFail()
            }
        }, waitFor: 1.0)
    }
    
    func testSortByPrice() {
        mockRequestManager.shouldSucceed = true
        testExpectation(description: "Search songs", actionBlock: { (expectation) in
            let interactor = BrowseSongsInteractor(requestManager: mockRequestManager)
            interactor.seachSongs(with: [], successBlock: { (response) in
                let sortOption = SortOption(mode: .price, inverted: false)
                let songList = interactor.getSortedBy(sortOption: sortOption)
                XCTAssertNotNil(songList.first)
                XCTAssertNotNil(songList.last)
                XCTAssert(songList.first!.trackPrice > songList.last!.trackPrice)
                expectation.fulfill()
            }) {
                XCTFail()
            }
        }, waitFor: 1.0)
    }
    
    func testSortByLength() {
        mockRequestManager.shouldSucceed = true
        testExpectation(description: "Search songs", actionBlock: { (expectation) in
            let interactor = BrowseSongsInteractor(requestManager: mockRequestManager)
            interactor.seachSongs(with: [], successBlock: { (response) in
                let sortOption = SortOption(mode: .length, inverted: false)
                let songList = interactor.getSortedBy(sortOption: sortOption)
                XCTAssertNotNil(songList.first)
                XCTAssertNotNil(songList.last)
                XCTAssert(songList.first!.trackTimeMillis > songList.last!.trackTimeMillis)
                expectation.fulfill()
            }) {
                XCTFail()
            }
        }, waitFor: 1.0)
    }
    
    func testSortByGenre() {
        mockRequestManager.shouldSucceed = true
        testExpectation(description: "Search songs", actionBlock: { (expectation) in
            let interactor = BrowseSongsInteractor(requestManager: mockRequestManager)
            interactor.seachSongs(with: [], successBlock: { (response) in
                let sortOption = SortOption(mode: .genre, inverted: false)
                let songList = interactor.getSortedBy(sortOption: sortOption)
                XCTAssertNotNil(songList.first)
                XCTAssertNotNil(songList.last)
                XCTAssert(songList.first!.primaryGenreName > songList.last!.primaryGenreName)
                expectation.fulfill()
            }) {
                XCTFail()
            }
        }, waitFor: 1.0)
    }

}
